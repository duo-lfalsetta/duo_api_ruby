require_relative 'common'


class TestHelpersBasic < TestCase
  def setup
    super
    @mock_http = mock()
    Net::HTTP.expects(:start).yields(@mock_http)

    @json_ok_str_resp = MockResponse.new(
      '200',
      {
        stat: 'OK',
        response: 'RESPONSE STRING'
      },
      {'Content-Type' => 'application/json'}
    )

    @json_ok_arr_resp = MockResponse.new(
      '200',
      {
        stat: 'OK',
        response: [ 'RESPONSE1', 'RESPONSE2' ]
      },
      {'Content-Type' => 'application/json'}
    )

    @json_fail = MockResponse.new(
      '400',
      {
        stat: 'FAIL',
        message: 'ERROR MESSAGE',
        message_detail: 'ERROR MESSAGE DETAIL'
      },
      {'content-type' => 'application/json'}
    )

    @json_invalid = MockResponse.new(
      '200',
      'This is not valid JSON.',
      {'content-type' => 'application/json'}
    )

    @image_ok = MockResponse.new(
      '200',
      Base64::decode64('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAA' +
                       'AfFcSJAAAAAXNSR0IArs4c6QAAAA1JREFUGFdj' +
                       'yN7v9x8ABYkCeCbwZGwAAAAASUVORK5CYII='),
                       {'content-type' => 'image/png'}
    )
  end


  # @client.get()
  def test_get_ok
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    actual_response = @client.get('/fake')
    assert_equal(JSON.parse(@json_ok_str_resp.body), actual_response)
  end

  def test_get_fail
    @mock_http.expects(:request).returns(@json_fail)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail.code}: #{@json_fail.body}"){ @client.get('/fake') }
  end

  def test_get_invalid_response_format
    @mock_http.expects(:request).returns(@json_invalid)
    assert_raise(JSON::ParserError){ @client.get('/fake') }
  end

  def test_get_invalid_response_content_type
    @mock_http.expects(:request).returns(@image_ok)
    assert_raise_with_message(
      DuoApi::ContentTypeError,
      'Invalid Content-Type image/png, should match "application/json"'){ @client.get('/fake') }
  end


  # @client.get_all()
  def test_get_all_ok
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    actual_response = @client.get_all('/fake')
    assert_equal(JSON.parse(@json_ok_arr_resp.body), actual_response)
  end

  def test_get_all_fail
    @mock_http.expects(:request).returns(@json_fail)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail.code}: #{@json_fail.body}"){ @client.get_all('/fake') }
  end

  def test_get_all_invalid
    @mock_http.expects(:request).returns(@json_invalid)
    assert_raise(JSON::ParserError){ @client.get_all('/fake') }
  end


  # @client.get_image()
  def test_get_image_ok
    @mock_http.expects(:request).returns(@image_ok)
    actual_response = @client.get_image('/fake')
    assert_equal(@image_ok.body, actual_response)
  end

  def test_get_image_fail
    @mock_http.expects(:request).returns(@json_fail)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail.code}: #{@json_fail.body}"){ @client.get_image('/fake') }
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
    assert_equal(JSON.parse(@json_ok_str_resp.body), actual_response)
  end

  def test_post_fail
    @mock_http.expects(:request).returns(@json_fail)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail.code}: #{@json_fail.body}"){ @client.post('/fake') }
  end

  def test_post_invalid_response_format
    @mock_http.expects(:request).returns(@json_invalid)
    assert_raise(JSON::ParserError){ @client.post('/fake') }
  end

  def test_post_invalid_response_content_type
    @mock_http.expects(:request).returns(@image_ok)
    assert_raise_with_message(
      DuoApi::ContentTypeError,
      'Invalid Content-Type image/png, should match "application/json"'){ @client.post('/fake') }
  end


  # @client.put()
  def test_put_ok
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    actual_response = @client.put('/fake')
    assert_equal(JSON.parse(@json_ok_str_resp.body), actual_response)
  end

  def test_put_fail
    @mock_http.expects(:request).returns(@json_fail)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail.code}: #{@json_fail.body}"){ @client.put('/fake') }
  end

  def test_put_invalid_response_format
    @mock_http.expects(:request).returns(@json_invalid)
    assert_raise(JSON::ParserError){ @client.put('/fake') }
  end

  def test_put_invalid_response_content_type
    @mock_http.expects(:request).returns(@image_ok)
    assert_raise_with_message(
      DuoApi::ContentTypeError,
      'Invalid Content-Type image/png, should match "application/json"'){ @client.put('/fake') }
  end


  # @client.delete()
  def test_delete_ok
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    actual_response = @client.delete('/fake')
    assert_equal(JSON.parse(@json_ok_str_resp.body), actual_response)
  end

  def test_delete_fail
    @mock_http.expects(:request).returns(@json_fail)
    assert_raise_with_message(
      DuoApi::ResponseCodeError,
      "HTTP #{@json_fail.code}: #{@json_fail.body}"){ @client.delete('/fake') }
  end

  def test_delete_invalid_response_format
    @mock_http.expects(:request).returns(@json_invalid)
    assert_raise(JSON::ParserError){ @client.delete('/fake') }
  end

  def test_delete_invalid_response_content_type
    @mock_http.expects(:request).returns(@image_ok)
    assert_raise_with_message(
      DuoApi::ContentTypeError,
      'Invalid Content-Type image/png, should match "application/json"'){ @client.delete('/fake') }
  end
end
