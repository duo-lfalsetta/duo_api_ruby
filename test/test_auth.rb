require_relative 'common'


class TestAuth < HTTPTestCase
  setup
  def setup_globals
    @auth_api = DuoApi::Auth.new(IKEY, SKEY, HOST)

    @json_ok = MockResponse.new(
      '200',
      {
        stat: 'OK',
        response: 'RESPONSE STRING'
      },
      {'Content-Type': 'application/json'}
    )

    @image_ok = MockResponse.new(
      '200',
      Base64::decode64('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAA' +
                       'AfFcSJAAAAAXNSR0IArs4c6QAAAA1JREFUGFdj' +
                       'yN7v9x8ABYkCeCbwZGwAAAAASUVORK5CYII='),
                       {'content-type' => 'image/png'}
    )

    @wrong_number_of_args_message = 'wrong number of arguments (given 1, expected 0)'
  end


  def test_ping
    @mock_http.expects(:request).returns(@json_ok)
    assert_nothing_raised(){ @auth_api.ping() }
  end

  def test_check
    @mock_http.expects(:request).returns(@json_ok)
    assert_nothing_raised(){ @auth_api.check() }
  end

  def test_logo
    @mock_http.expects(:request).returns(@image_ok)
    assert_nothing_raised(){ @auth_api.logo() }
  end

  def test_enroll
    @mock_http.expects(:request).returns(@json_ok)
    assert_nothing_raised(){ @auth_api.enroll() }
  end

  def test_enroll_status
    @mock_http.expects(:request).returns(@json_ok)
    required_args = {user_id: 'USERID', activation_code: 'CODE'}
    assert_nothing_raised(){ @auth_api.enroll_status(**required_args) }
  end

  def test_enroll_status_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :activation_code]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @auth_api.enroll_status() }
  end

  def test_preauth
    @mock_http.expects(:request).returns(@json_ok)
    assert_nothing_raised(){ @auth_api.preauth() }
  end

  def test_auth
    @mock_http.expects(:request).returns(@json_ok)
    required_args = {factor: 'auto'}
    assert_nothing_raised(){ @auth_api.auth(**required_args) }
  end

  def test_auth_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:factor]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @auth_api.auth() }
  end

  def test_auth_status
    @mock_http.expects(:request).returns(@json_ok)
    required_args = {txid: 'TXID'}
    assert_nothing_raised(){ @auth_api.auth_status(**required_args) }
  end

  def test_auth_status_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:txid]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @auth_api.auth_status() }
  end
end
