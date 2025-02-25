require_relative 'common'


class TestAccounts < HTTPTestCase
  setup
  def setup_globals
    @accounts_api = DuoApi::Accounts.new(IKEY, SKEY, HOST)

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

    @child_account_id_good = 'DAGOODCHILDACCOUNTID'
    @child_account_id_bad = 'DABADCHILDACCOUNTID'
    @child_account_json_ok = MockResponse.new(
      '200',
      {
        stat: 'OK',
        response: [{
          account_id: @child_account_id_good,
          api_hostname: HOST,
          name: 'Child Account 1'
        }]
      },
      {'Content-Type': 'application/json'}
    )

    @wrong_number_of_args_message = 'wrong number of arguments (given 1, expected 0)'
  end


  def test_get_child_accounts
    @mock_http.expects(:request).returns(@json_ok)
    assert_nothing_raised(){ @accounts_api.get_child_accounts() }
  end

  def test_create_child_account
    @mock_http.expects(:request).times(0)
    required_args = [:name]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @accounts_api.create_child_account() }
  end

  def test_delete_child_account
    @mock_http.expects(:request).times(0)
    required_args = [:account_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @accounts_api.delete_child_account() }
  end


  def test_admin_api
    @mock_http.expects(:request).returns(@child_account_json_ok)
    assert_instance_of(DuoApi::Admin,
                       @accounts_api.admin_api(child_account_id: @child_account_id_good))
  end

  def test_admin_api_bad_child_account
    @mock_http.expects(:request).returns(@child_account_json_ok)
    assert_raise_with_message(
      DuoApi::ChildAccountError,
      "Child account #{@child_account_id_bad} not found"
    ){ @accounts_api.admin_api(child_account_id: @child_account_id_bad) }
  end

  def test_admin_api_get_edition
    @mock_http.expects(:request).twice.returns(@child_account_json_ok, @json_ok)
    accounts_admin_api = @accounts_api.admin_api(child_account_id: @child_account_id_good)
    assert_nothing_raised(){ accounts_admin_api.get_edition() }
  end
  
  def test_admin_api_set_edition
    @mock_http.expects(:request).returns(@child_account_json_ok)
    accounts_admin_api = @accounts_api.admin_api(child_account_id: @child_account_id_good)
    required_args = [:edition]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ accounts_admin_api.set_edition() }
  end

  def test_admin_api_get_telephony_credits
    @mock_http.expects(:request).twice.returns(@child_account_json_ok, @json_ok)
    accounts_admin_api = @accounts_api.admin_api(child_account_id: @child_account_id_good)
    assert_nothing_raised(){ accounts_admin_api.get_telephony_credits() }
  end

  def test_admin_api_set_telephony_credits
    @mock_http.expects(:request).returns(@child_account_json_ok)
    accounts_admin_api = @accounts_api.admin_api(child_account_id: @child_account_id_good)
    required_args = [:credits]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ accounts_admin_api.set_telephony_credits() }
  end
end
