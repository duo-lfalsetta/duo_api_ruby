require_relative 'client'

class DuoApi

  def get(path, params = {}, additional_headers = nil)
    resp = request('GET', path, serialized_params_for_uri(params), additional_headers)
    raise_http_errors(resp)
    JSON.parse(resp.body)
  end

  def get_all(path, params = {}, additional_headers = nil)
    warn 'Ignoring supplied offset parameter for get_all method' if params[:offset]
    params[:limit] ||= 1000
    params[:offset] = 0

    all_resp_data = []
    prev_resp_data_count = 0
    prev_offset = 0
    while params[:offset]
      resp = request('GET', path, serialized_params_for_uri(params), additional_headers)
      raise_http_errors(resp)
      resp_body = JSON.parse(resp.body)
      all_resp_data.concat(resp_body['response'])
      if resp_body['metadata']
        params[:offset] = resp_body['metadata']['next_offset']
      else
        params[:offset] = nil
      end

      raise 'Paginated response offset error' if params[:offset] and not params[:offset] > prev_offset
      raise 'Paginated response count error' if not all_resp_data.count > prev_resp_data_count

      prev_resp_data_count = all_resp_data.count
      prev_offset = params[:offset]
    end
    resp_body['response'] = all_resp_data
    resp_body
  end

  def post(path, params = {}, additional_headers = nil)
    resp = request('POST', path, params, additional_headers)
    raise_http_errors(resp)
    JSON.parse(resp.body)
  end

  def put(path, params = {}, additional_headers = nil)
    resp = request('PUT', path, params, additional_headers)
    raise_http_errors(resp)
    JSON.parse(resp.body)
  end

  def delete(path, params = {}, additional_headers = nil)
    resp = request('DELETE', path, params, additional_headers)
    raise_http_errors(resp)
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

  def serialized_params_for_uri(params)
    params.keys.each do |k|
      params[k] = JSON.generate(params[k]) if params[k].is_a?(Array)
    end
    params
  end
  
end
