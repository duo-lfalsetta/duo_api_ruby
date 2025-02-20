require_relative 'client'


# Extend DuoApi class with some HTTP method helpers
class DuoApi

  # Perform a GET request and parse the response as JSON
  def get(path, params = {}, additional_headers = nil)
    resp = request('GET', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], 'application/json')

    JSON.parse(resp.body)
  end

  # Perform a GET request and retrieve all paginated JSON data
  def get_all(path, params = {}, additional_headers = nil, data_array_path: nil, metadata_path: nil)
    # Set default paths for returned data array and metadata if not provided
    data_array_path = (data_array_path.is_a?(Array) and data_array_path.count >= 1) ?
      data_array_path : ['response']
    metadata_path = (metadata_path.is_a?(Array) and metadata_path.count >= 1) ?
      metadata_path : ['metadata']

    # Ensure params keys are symbols and ignore offset parameters
    params.transform_keys!(&:to_sym)
    [:offset, :next_offset].each do |p|
      if params[p]
        warn "Ignoring supplied #{p} parameter for get_all method"
        params.delete(p)
      end
    end
    # Default :limit to 1000 unless specified to minimized requests
    params[:limit] ||= 1000

    all_data = []
    prev_results_count = 0
    next_offset = 0
    prev_offset = 0
    resp_body_hash = {}
    loop do
      resp = request('GET', path, params, additional_headers)
      raise_http_errors(resp)
      raise_content_type_errors(resp['content-type'], 'application/json')

      resp_body_hash = JSON.parse(resp.body)
      resp_data_array = resp_body_hash.dig(*data_array_path)
      if not resp_data_array.is_a?(Array)
        raise(PaginationError,
              "Object at data_array_path #{JSON.generate(data_array_path)} is not an Array")
      end
      all_data.concat(resp_data_array)

      resp_metadata = resp_body_hash.dig(*metadata_path)
      if resp_metadata.is_a?(Hash) and resp_metadata['next_offset']
        next_offset = resp_metadata['next_offset']
        next_offset = next_offset.to_i if is_string_int?(next_offset)

        if next_offset.is_a?(Array) or next_offset.is_a?(String)
          next_offset = next_offset.join(',') if next_offset.is_a?(Array)
          raise(PaginationError, 'Paginated response offset error') if next_offset == prev_offset
          params[:next_offset] = next_offset
        else
          raise(PaginationError, 'Paginated response offset error') if not next_offset > prev_offset
          params[:offset] = next_offset
        end
      else
        next_offset = nil
        params.delete(:offset)
        params.delete(:next_offset)
      end

      break if not next_offset or
        not all_data.count > prev_results_count

      prev_results_count = all_data.count
      prev_offset = next_offset
    end

    # Replace the data array in the last returned resp_body_hash with the all_data array
    if data_array_path.count > 1
      data_array_parent_hash = resp_body_hash.dig(*data_array_path[0..-2])
    else
      data_array_parent_hash = resp_body_hash
    end
    data_array_key = data_array_path.last
    data_array_parent_hash[data_array_key] = all_data

    resp_body_hash
  end

  # Perform a GET request to retrieve image data and return raw data
  def get_image(path, params = {}, additional_headers = nil)
    resp = request('GET', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], /^image\//)

    resp.body
  end

  # Perform a POST request and parse the response as JSON
  def post(path, params = {}, additional_headers = nil)
    resp = request('POST', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], 'application/json')

    JSON.parse(resp.body)
  end

  # Perform a PUT request and parse the response as JSON
  def put(path, params = {}, additional_headers = nil)
    resp = request('PUT', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], 'application/json')

    JSON.parse(resp.body)
  end

  # Perform a DELETE request and parse the response as JSON
  def delete(path, params = {}, additional_headers = nil)
    resp = request('DELETE', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], 'application/json')

    JSON.parse(resp.body)
  end


  private

  # Raise errors for non-successful HTTP responses
  def raise_http_errors(resp)
    return if resp.is_a?(Net::HTTPSuccess)
    case resp.code
    when '200'
      return
    when RATE_LIMITED_RESP_CODE
      raise(RateLimitError, 'Rate limit retry max wait exceeded')
    else
      raise(ResponseCodeError, "HTTP #{resp.code}: #{resp.body}")
    end
  end

  # Validate the content type of the response against the expected type
  def raise_content_type_errors(received, allowed)
    valid = false
    if allowed.is_a?(Regexp)
      valid = true if received =~ allowed
    else
      valid = true if received == allowed
    end
    raise(ContentTypeError,
          "Invalid Content-Type #{received}, should match #{allowed.inspect}") if not valid
  end

  # Check if a value is a Base64 encoded string
  def is_base64?(value)
    begin
      value.is_a?(String) and Base64.strict_encode64(Base64.decode64(value)) == value
    rescue
      false
    end
  end

  # Check if a string represents an integer
  def is_string_int?(value)
    begin
      value.is_a?(String) and value.to_i.to_s == value
    rescue
      false
    end
  end

end
