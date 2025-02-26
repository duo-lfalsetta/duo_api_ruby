require_relative 'common'


class TestHelpersBasic < HTTPTestCase
  # @client.get()
  def test_get_ok
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    actual_response = @client.get('/fake')
    assert_equal(parse_json_to_sym_hash(@json_ok_str_resp.body), actual_response)
  end

  def test_get_fail
    @mock_http.expects(:request).returns(@json_fail_resp)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail_resp.code}: #{@json_fail_resp.body}"){ @client.get('/fake') }
  end

  def test_get_invalid_response_format
    @mock_http.expects(:request).returns(@json_invalid_resp)
    assert_raise(JSON::ParserError){ @client.get('/fake') }
  end

  def test_get_invalid_response_content_type
    @mock_http.expects(:request).returns(@image_ok_resp)
    assert_raise_with_message(
      DuoApi::ContentTypeError,
      'Invalid Content-Type image/png, should match "application/json"'){ @client.get('/fake') }
  end

  def test_get_ratelimit_timeout
    @mock_http.expects(:request).times(7).returns(@ratelimit_resp)
    @client.expects(:rand).times(6).returns(0.123)
    @client.expects(:sleep).with(1.123)
    @client.expects(:sleep).with(2.123)
    @client.expects(:sleep).with(4.123)
    @client.expects(:sleep).with(8.123)
    @client.expects(:sleep).with(16.123)
    @client.expects(:sleep).with(32.123)
    assert_raise_with_message(
      DuoApi::RateLimitError,
      'Rate limit retry max wait exceeded'){ @client.get('/fake') }
  end


  # @client.get_all()
  def test_get_all_ok
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    actual_response = @client.get_all('/fake')
    assert_equal(parse_json_to_sym_hash(@json_ok_arr_resp.body), actual_response)
  end

  def test_get_all_fail
    @mock_http.expects(:request).returns(@json_fail_resp)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail_resp.code}: #{@json_fail_resp.body}"){ @client.get_all('/fake') }
  end

  def test_get_all_invalid
    @mock_http.expects(:request).returns(@json_invalid_resp)
    assert_raise(JSON::ParserError){ @client.get_all('/fake') }
  end


  # @client.get_image()
  def test_get_image_ok
    @mock_http.expects(:request).returns(@image_ok_resp)
    actual_response = @client.get_image('/fake')
    assert_equal(@image_ok_resp.body, actual_response)
  end

  def test_get_image_fail
    @mock_http.expects(:request).returns(@json_fail_resp)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail_resp.code}: #{@json_fail_resp.body}"){ @client.get_image('/fake') }
  end

  def test_get_image_invalid_response_content_type
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    assert_raise_with_message(
      DuoApi::ContentTypeError,
      'Invalid Content-Type application/json, should match /^image\//'){ @client.get_image('/fake') }
  end


  # @client.post()
  def test_post_ok
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    actual_response = @client.post('/fake')
    assert_equal(parse_json_to_sym_hash(@json_ok_str_resp.body), actual_response)
  end

  def test_post_fail
    @mock_http.expects(:request).returns(@json_fail_resp)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail_resp.code}: #{@json_fail_resp.body}"){ @client.post('/fake') }
  end

  def test_post_invalid_response_format
    @mock_http.expects(:request).returns(@json_invalid_resp)
    assert_raise(JSON::ParserError){ @client.post('/fake') }
  end

  def test_post_invalid_response_content_type
    @mock_http.expects(:request).returns(@image_ok_resp)
    assert_raise_with_message(
      DuoApi::ContentTypeError,
      'Invalid Content-Type image/png, should match "application/json"'){ @client.post('/fake') }
  end


  # @client.put()
  def test_put_ok
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    actual_response = @client.put('/fake')
    assert_equal(parse_json_to_sym_hash(@json_ok_str_resp.body), actual_response)
  end

  def test_put_fail
    @mock_http.expects(:request).returns(@json_fail_resp)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail_resp.code}: #{@json_fail_resp.body}"){ @client.put('/fake') }
  end

  def test_put_invalid_response_format
    @mock_http.expects(:request).returns(@json_invalid_resp)
    assert_raise(JSON::ParserError){ @client.put('/fake') }
  end

  def test_put_invalid_response_content_type
    @mock_http.expects(:request).returns(@image_ok_resp)
    assert_raise_with_message(
      DuoApi::ContentTypeError,
      'Invalid Content-Type image/png, should match "application/json"'){ @client.put('/fake') }
  end


  # @client.delete()
  def test_delete_ok
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    actual_response = @client.delete('/fake')
    assert_equal(parse_json_to_sym_hash(@json_ok_str_resp.body), actual_response)
  end

  def test_delete_fail
    @mock_http.expects(:request).returns(@json_fail_resp)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail_resp.code}: #{@json_fail_resp.body}"){ @client.delete('/fake') }
  end

  def test_delete_invalid_response_format
    @mock_http.expects(:request).returns(@json_invalid_resp)
    assert_raise(JSON::ParserError){ @client.delete('/fake') }
  end

  def test_delete_invalid_response_content_type
    @mock_http.expects(:request).returns(@image_ok_resp)
    assert_raise_with_message(
      DuoApi::ContentTypeError,
      'Invalid Content-Type image/png, should match "application/json"'){ @client.delete('/fake') }
  end
end


class TestHelpersPaginated < HTTPTestCase
  setup
  def setup_test_globals
    @standard_paged_response_1 = MockResponse.new(
      '200',
      {
        stat: 'OK',
        response: [ 'RESPONSE1', 'RESPONSE2' ],
        metadata: {
          total_objects: 4,
          next_offset: 2,
          prev_offset: 0
        }
      },
      {'Content-Type' => 'application/json'}
    )

    @standard_paged_response_2 = MockResponse.new(
      '200',
      JSON.generate({
        stat: 'OK',
        response: [ 'RESPONSE3', 'RESPONSE4' ],
        metadata: {
          total_objects: 4,
          prev_offset: 2
        }
      }),
      {'Content-Type' => 'application/json'}
    )

    @standard_paged_combined_results = {
      stat: 'OK',
      response: [ 'RESPONSE1', 'RESPONSE2', 'RESPONSE3', 'RESPONSE4' ],
      metadata: {
        total_objects: 4,
        prev_offset: 2
      }
    }

    @nonstandard_paged_response_1 = MockResponse.new(
      '200',
      JSON.generate({
        stat: 'OK',
        response: {
          items: [ 'RESPONSE1', 'RESPONSE2' ],
          metadata: {
            next_offset: ['1738997429000', 'cb306faf-7f36-494d-9a0e-5697d93331f8']
          }
        }
      }),
      {'Content-Type' => 'application/json'}
    )

    @nonstandard_paged_response_2 = MockResponse.new(
      '200',
      JSON.generate({
        stat: 'OK',
        response: {
          items: [ 'RESPONSE3', 'RESPONSE4' ],
          metadata: {}
        }
      }),
      {'Content-Type' => 'application/json'}
    )

    @nonstandard_paged_combined_results = {
      stat: 'OK',
      response: {
        items: [ 'RESPONSE1', 'RESPONSE2', 'RESPONSE3', 'RESPONSE4' ],
        metadata: {}
      }
    }
  end


  def test_get_all_standard_paged_ok
    @mock_http.expects(:request).twice.returns(
      @standard_paged_response_1, @standard_paged_response_2)
    actual_response = @client.get_all('/fake')
    assert_equal(@standard_paged_combined_results, actual_response)
  end

  def test_get_all_nonstandard_paged_ok
    @mock_http.expects(:request).twice.returns(
      @nonstandard_paged_response_1, @nonstandard_paged_response_2)
    actual_response = @client.get_all('/fake',
                                      data_array_path: ['response', 'items'],
                                      metadata_path: ['response', 'metadata'])
    assert_equal(@nonstandard_paged_combined_results, actual_response)
  end

  def test_get_all_bad_data_array_path
    @mock_http.expects(:request).returns(@nonstandard_paged_response_1)
    assert_raise_with_message(
      DuoApi::PaginationError,
      'Object at data_array_path ["response"] is not an Array'){
        @client.get_all('/fake', metadata_path: ['response', 'metadata'])}
  end
end
