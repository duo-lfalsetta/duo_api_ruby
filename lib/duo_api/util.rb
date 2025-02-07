require_relative 'client'

class DuoApi

  def get(path, params = {}, additional_headers = nil)
    resp = request('GET', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], 'application/json')

    JSON.parse(resp.body)
  end

  def get_all(path, params = {}, additional_headers = nil)
    warn 'Ignoring supplied offset parameter for get_all method' if params[:offset]
    params.delete(:offset)
    params.delete(:next_offset)
    params[:limit] ||= 1000

    metadata_path = ['metadata']
    results_path = ['response']
    all_results = []
    prev_results_count = 0
    next_offset = 0
    prev_offset = 0
    resp_body_hash = {}
    loop do
      resp = request('GET', path, params, additional_headers)
      raise_http_errors(resp)
      raise_content_type_errors(resp['content-type'], 'application/json')

      resp_body_hash = JSON.parse(resp.body)
      if resp_body_hash['response'].is_a?(Hash) and results_path.count == 1
        array_keys = resp_body_hash['response'].select{|k,v| v.is_a?(Array)}.keys
        raise 'Unable to determine path of results array' if array_keys.count != 1
        results_path.append(array_keys.first)
      end
      if not resp_body_hash['metadata'] and resp_body_hash['response'].is_a?(Hash)
        metadata_path = ['response', 'metadata']
      end

      all_results.concat(resp_body_hash.dig(*results_path))
      resp_metadata = resp_body_hash.dig(*metadata_path)
      if resp_metadata and resp_metadata['next_offset']
        next_offset = resp_metadata['next_offset']
        if next_offset.is_a?(Array) or next_offset.is_a?(String)
          next_offset = next_offset.join(',') if next_offset.is_a?(Array)
          raise 'Paginated response offset error' if next_offset == prev_offset
          params[:next_offset] = next_offset
        else
          raise 'Paginated response offset error' if not next_offset > prev_offset
          params[:offset] = next_offset
        end
      else
        next_offset = nil
        params.delete(:offset)
        params.delete(:next_offset)
      end

      break if not next_offset or 
        not all_results.count > prev_results_count

      prev_results_count = all_results.count
      prev_offset = next_offset
    end
    
    if results_path.count > 1
      results_base_hash = resp_body_hash.dig(*results_path[..-2])
    else
      results_base_hash = resp_body_hash
    end
    results_array_key = results_path.last
    results_base_hash[results_array_key] = all_results
    resp_body_hash
  end

  def get_image(path, params = {}, additional_headers = nil)
    resp = request('GET', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], /^image\//)

    resp.body
  end  

  def post(path, params = {}, additional_headers = nil)
    resp = request('POST', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], 'application/json')

    JSON.parse(resp.body)
  end

  def put(path, params = {}, additional_headers = nil)
    resp = request('PUT', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], 'application/json')

    JSON.parse(resp.body)
  end

  def delete(path, params = {}, additional_headers = nil)
    resp = request('DELETE', path, params, additional_headers)
    raise_http_errors(resp)
    raise_content_type_errors(resp['content-type'], 'application/json')

    JSON.parse(resp.body)
  end


  private

  def raise_http_errors(resp)
    return if resp.kind_of? Net::HTTPSuccess
    case resp.code
    when '200'
      return
    when RATE_LIMITED_RESP_CODE
      raise 'Rate limit retry max wait exceeded'
    else
      raise "HTTP #{resp.code}: #{JSON.parse(resp.body)}"
    end
  end

  def raise_content_type_errors(received, allowed)
    valid = false
    if allowed.is_a?(Regexp)
      valid = true if received =~ allowed
    else
      valid = true if received == allowed
    end
    raise "Invalid Content-Type #{received}, should match #{allowed}" if not valid
  end

  def is_base64?(value)
    begin
      value.is_a?(String) and Base64.strict_encode64(Base64.decode64(value)) == value
    rescue
      false
    end
  end

end
