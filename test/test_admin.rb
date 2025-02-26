require_relative 'common'


##
# DuoApi::Admin tests
#
class TestAdmin < HTTPTestCase
  setup
  def setup_test_globals
    @admin_api = DuoApi::Admin.new(IKEY, SKEY, HOST)

    @authlogs_ok_resp = MockResponse.new(
      '200',
      {
        stat: 'OK',
        response: {
          authlogs: [ 'RESPONSE1', 'RESPONSE2' ]
        }
      },
      {'Content-Type': 'application/json'}
    )

    @items_ok_resp = MockResponse.new(
      '200',
      {
        stat: 'OK',
        response: {
          items: [ 'RESPONSE1', 'RESPONSE2' ]
        }
      },
      {'Content-Type': 'application/json'}
    )

    @events_ok_resp = MockResponse.new(
      '200',
      {
        stat: 'OK',
        response: {
          events: [ 'RESPONSE1', 'RESPONSE2' ]
        }
      },
      {'Content-Type': 'application/json'}
    )
  end


  ##
  # Users
  #
  def test_get_users
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_users() }
  end

  def test_create_user
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {username: 'USERNAME'}
    assert_nothing_raised(){ @admin_api.create_user(**required_args) }
  end

  def test_create_user_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:username]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_user() }
  end

  def test_bulk_create_users
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {users: [{username: 'USERNAME1'}, {username: 'USERNAME2'}]}
    assert_nothing_raised(){ @admin_api.bulk_create_users(**required_args) }
  end

  def test_bulk_create_users_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:users]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.bulk_create_users() }
  end

  def test_bulk_restore_users
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {user_id_list: ['USERID1', 'USERID2']}
    assert_nothing_raised(){ @admin_api.bulk_restore_users(**required_args) }
  end

  def test_bulk_restore_users_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id_list]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.bulk_restore_users() }
  end

  def test_bulk_trash_users
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {user_id_list: ['USERID1', 'USERID2']}
    assert_nothing_raised(){ @admin_api.bulk_trash_users(**required_args) }
  end

  def test_bulk_trash_users_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id_list]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.bulk_trash_users() }
  end

  def test_get_user
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.get_user(**required_args) }
  end

  def test_get_user_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_user() }
  end

  def test_update_user
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.update_user(**required_args) }
  end

  def test_update_user_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_user() }
  end

  def test_delete_user
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.delete_user(**required_args) }
  end

  def test_delete_user_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_user() }
  end

  def test_enroll_user
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {username: 'USERNAME', email: 'EMAIL'}
    assert_nothing_raised(){ @admin_api.enroll_user(**required_args) }
  end

  def test_enroll_user_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:username, :email]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.enroll_user() }
  end

  def test_create_user_bypass_codes
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.create_user_bypass_codes(**required_args) }
  end

  def test_create_user_bypass_codes_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_user_bypass_codes() }
  end

  def test_get_user_bypass_codes
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.get_user_bypass_codes(**required_args) }
  end

  def test_get_user_bypass_codes_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_user_bypass_codes() }
  end

  def test_get_user_groups
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.get_user_groups(**required_args) }
  end

  def test_get_user_groups_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_user_groups() }
  end

  def test_add_user_group
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {user_id: 'USERID', group_id: 'GROUPID'}
    assert_nothing_raised(){ @admin_api.add_user_group(**required_args) }
  end

  def test_add_user_group_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :group_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.add_user_group() }
  end

  def test_remove_user_group
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {user_id: 'USERID', group_id: 'GROUPID'}
    assert_nothing_raised(){ @admin_api.remove_user_group(**required_args) }
  end

  def test_remove_user_group_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :group_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.remove_user_group() }
  end

  def test_get_user_phones
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.get_user_phones(**required_args) }
  end

  def test_get_user_phones_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_user_phones() }
  end

  def test_add_user_phone
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {user_id: 'USERID', phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.add_user_phone(**required_args) }
  end

  def test_add_user_phone_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.add_user_phone() }
  end

  def test_remove_user_phone
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {user_id: 'USERID', phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.remove_user_phone(**required_args) }
  end

  def test_remove_user_phone_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.remove_user_phone() }
  end

  def test_get_user_hardware_tokens
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.get_user_hardware_tokens(**required_args) }
  end

  def test_get_user_hardware_tokens_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_user_hardware_tokens() }
  end

  def test_add_user_hardware_token
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {user_id: 'USERID', token_id: 'TOKENID'}
    assert_nothing_raised(){ @admin_api.add_user_hardware_token(**required_args) }
  end

  def test_add_user_hardware_token_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :token_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.add_user_hardware_token() }
  end

  def test_remove_user_hardware_token
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {user_id: 'USERID', token_id: 'TOKENID'}
    assert_nothing_raised(){ @admin_api.remove_user_hardware_token(**required_args) }
  end

  def test_remove_user_hardware_token_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :token_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.remove_user_hardware_token() }
  end

  def test_get_user_webauthn_credentials
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.get_user_webauthn_credentials(**required_args) }
  end

  def test_get_user_webauthn_credentials_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_user_webauthn_credentials() }
  end

  def test_get_user_desktop_authenticators
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.get_user_desktop_authenticators(**required_args) }
  end

  def test_get_user_desktop_authenticators_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_user_desktop_authenticators() }
  end

  def test_sync_user
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {username: 'USERNAME', directory_key: 'DIRECTORYKEY'}
    assert_nothing_raised(){ @admin_api.sync_user(**required_args) }
  end

  def test_sync_user_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:username, :directory_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.sync_user() }
  end

  def test_send_verification_push
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {user_id: 'USERID', phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.send_verification_push(**required_args) }
  end

  def test_send_verification_push_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.send_verification_push() }
  end

  def test_get_verification_push_response
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {user_id: 'USERID', push_id: 'PUSHID'}
    assert_nothing_raised(){ @admin_api.get_verification_push_response(**required_args) }
  end

  def test_get_verification_push_response_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :push_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_verification_push_response() }
  end


  ##
  # Bulk Operations
  #
  def test_bulk_operations
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {operations: [{method: 'POST', path: '/fake', body: {KEY: 'VALUE'}}]}
    assert_nothing_raised(){ @admin_api.bulk_operations(**required_args) }
  end

  def test_bulk_operations_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:operations]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.bulk_operations() }
  end


  ##
  # Groups
  #
  def test_get_groups
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_groups() }
  end

  def test_create_group
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {name: 'NAME'}
    assert_nothing_raised(){ @admin_api.create_group(**required_args) }
  end

  def test_create_group_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:name]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_group() }
  end

  def test_get_group
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {group_id: 'GROUPID'}
    assert_nothing_raised(){ @admin_api.get_group(**required_args) }
  end

  def test_get_group_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:group_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_group() }
  end

  def test_get_group_users
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {group_id: 'GROUPID'}
    assert_nothing_raised(){ @admin_api.get_group_users(**required_args) }
  end

  def test_get_group_users_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:group_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_group_users() }
  end

  def test_update_group
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {group_id: 'GROUPID'}
    assert_nothing_raised(){ @admin_api.update_group(**required_args) }
  end

  def test_update_group_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:group_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_group() }
  end

  def test_delete_group
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {group_id: 'GROUPID'}
    assert_nothing_raised(){ @admin_api.delete_group(**required_args) }
  end

  def test_delete_group_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:group_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_group() }
  end


  ##
  # Phones
  #
  def test_get_phones
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_phones() }
  end

  def test_create_phone
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {name: 'PHONENAME'}
    assert_nothing_raised(){ @admin_api.create_phone(**required_args) }
  end

  def test_get_phone
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.get_phone(**required_args) }
  end

  def test_get_phone_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_phone() }
  end

  def test_update_phone
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.update_phone(**required_args) }
  end

  def test_update_phone_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_phone() }
  end

  def test_delete_phone
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.delete_phone(**required_args) }
  end

  def test_delete_phone_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_phone() }
  end

  def test_create_activation_url
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.create_activation_url(**required_args) }
  end

  def test_create_activation_url_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_activation_url() }
  end

  def test_send_sms_activation
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.send_sms_activation(**required_args) }
  end

  def test_send_sms_activation_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.send_sms_activation() }
  end

  def test_send_sms_installation
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.send_sms_installation(**required_args) }
  end

  def test_send_sms_installation_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.send_sms_installation() }
  end

  def test_send_sms_passcodes
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {phone_id: 'PHONEID'}
    assert_nothing_raised(){ @admin_api.send_sms_passcodes(**required_args) }
  end

  def test_send_sms_passcodes_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:phone_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.send_sms_passcodes() }
  end

  ##
  # Tokens
  #
  def test_get_tokens
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_tokens() }
  end

  def test_create_token
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {type: 'TOKENTYPE', serial: 'TOKENSERIAL'}
    assert_nothing_raised(){ @admin_api.create_token(**required_args) }
  end

  def test_create_token_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:type, :serial]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_token() }
  end

  def test_get_token
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {token_id: 'TOKENID'}
    assert_nothing_raised(){ @admin_api.get_token(**required_args) }
  end

  def test_get_token_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:token_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_token() }
  end

  def test_resync_token
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {token_id: 'TOKENID', code1: 'CODE1', code2: 'CODE2', code3: 'CODE3'}
    assert_nothing_raised(){ @admin_api.resync_token(**required_args) }
  end

  def test_resync_token_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:token_id, :code1, :code2, :code3]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.resync_token() }
  end

  def test_delete_token
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {token_id: 'TOKENID'}
    assert_nothing_raised(){ @admin_api.delete_token(**required_args) }
  end

  def test_delete_token_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:token_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_token() }
  end


  ##
  # WebAuthn Credentials
  #
  def test_get_webauthncredentials
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_webauthncredentials() }
  end

  def test_get_webauthncredential
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {webauthnkey: 'WEBAUTHNKEY'}
    assert_nothing_raised(){ @admin_api.get_webauthncredential(**required_args) }
  end

  def test_get_webauthncredential_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:webauthnkey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_webauthncredential() }
  end

  def test_delete_webauthncredential
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {webauthnkey: 'WEBAUTHNKEY'}
    assert_nothing_raised(){ @admin_api.delete_webauthncredential(**required_args) }
  end

  def test_delete_webauthncredential_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:webauthnkey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_webauthncredential() }
  end


  ##
  # Desktop Authenticators
  #
  def test_get_desktop_authenticators
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_desktop_authenticators() }
  end

  def test_get_desktop_authenticator
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {dakey: 'DAKEY'}
    assert_nothing_raised(){ @admin_api.get_desktop_authenticator(**required_args) }
  end

  def test_get_desktop_authenticator_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:dakey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_desktop_authenticator() }
  end

  def test_delete_desktop_authenticator
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {dakey: 'DAKEY'}
    assert_nothing_raised(){ @admin_api.delete_desktop_authenticator(**required_args) }
  end

  def test_delete_desktop_authenticator_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:dakey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_desktop_authenticator() }
  end

  def test_get_shared_desktop_authenticators
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_shared_desktop_authenticators() }
  end

  def test_get_shared_desktop_authenticator
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {shared_device_key: 'SHAREDDEVICEKEY'}
    assert_nothing_raised(){ @admin_api.get_shared_desktop_authenticator(**required_args) }
  end

  def test_get_shared_desktop_authenticator_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:shared_device_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_shared_desktop_authenticator() }
  end

  def test_create_shared_desktop_authenticator
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {group_id_list: ['GROUPID1'], trusted_endpoint_integration_id_list: ['TEIID1']}
    assert_nothing_raised(){ @admin_api.create_shared_desktop_authenticator(**required_args) }
  end

  def test_create_shared_desktop_authenticator_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:group_id_list, :trusted_endpoint_integration_id_list]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_shared_desktop_authenticator() }
  end

  def test_update_shared_desktop_authenticator
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {shared_device_key: 'SHAREDDEVICEKEY'}
    assert_nothing_raised(){ @admin_api.update_shared_desktop_authenticator(**required_args) }
  end

  def test_update_shared_desktop_authenticator_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:shared_device_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_shared_desktop_authenticator() }
  end

  def test_delete_shared_desktop_authenticator
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {shared_device_key: 'SHAREDDEVICEKEY'}
    assert_nothing_raised(){ @admin_api.delete_shared_desktop_authenticator(**required_args) }
  end

  def test_delete_shared_desktop_authenticator_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:shared_device_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_shared_desktop_authenticator() }
  end


  ##
  # Bypass Codes
  #
  def test_get_bypass_codes
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_bypass_codes() }
  end

  def test_get_bypass_code
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {bypass_code_id: 'BYPASSCODEID'}
    assert_nothing_raised(){ @admin_api.get_bypass_code(**required_args) }
  end

  def test_get_bypass_code_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:bypass_code_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_bypass_code() }
  end

  def test_delete_bypass_code
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {bypass_code_id: 'BYPASSCODEID'}
    assert_nothing_raised(){ @admin_api.delete_bypass_code(**required_args) }
  end

  def test_delete_bypass_code_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:bypass_code_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_bypass_code() }
  end


  ##
  # Integrations
  #
  def test_get_integrations
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_integrations() }
  end

  def test_create_integration
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {name: 'INTEGRATIONNAME', type: 'INTEGRATIONTYPE'}
    assert_nothing_raised(){ @admin_api.create_integration(**required_args) }
  end

  def test_create_integration_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:name, :type]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_integration() }
  end

  def test_get_integration
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {integration_key: 'INTEGRATIONKEY'}
    assert_nothing_raised(){ @admin_api.get_integration(**required_args) }
  end

  def test_get_integration_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:integration_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_integration() }
  end

  def test_update_integration
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {integration_key: 'INTEGRATIONKEY'}
    assert_nothing_raised(){ @admin_api.update_integration(**required_args) }
  end

  def test_update_integration_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:integration_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_integration() }
  end

  def test_delete_integration
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {integration_key: 'INTEGRATIONKEY'}
    assert_nothing_raised(){ @admin_api.delete_integration(**required_args) }
  end

  def test_delete_integration_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:integration_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_integration() }
  end

  def test_get_integration_secret_key
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {integration_key: 'INTEGRATIONKEY'}
    assert_nothing_raised(){ @admin_api.get_integration_secret_key(**required_args) }
  end

  def test_get_integration_secret_key_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:integration_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_integration_secret_key() }
  end

  def test_get_oauth_integration_client_secret
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {integration_key: 'INTEGRATIONKEY', client_id: 'CLIENTID'}
    assert_nothing_raised(){ @admin_api.get_oauth_integration_client_secret(**required_args) }
  end

  def test_get_oauth_integration_client_secret_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:integration_key, :client_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_oauth_integration_client_secret() }
  end

  def test_reset_oauth_integration_client_secret
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {integration_key: 'INTEGRATIONKEY', client_id: 'CLIENTID'}
    assert_nothing_raised(){ @admin_api.reset_oauth_integration_client_secret(**required_args) }
  end

  def test_reset_oauth_integration_client_secret_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:integration_key, :client_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.reset_oauth_integration_client_secret() }
  end

  def test_get_oidc_integration_client_secret
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {integration_key: 'INTEGRATIONKEY'}
    assert_nothing_raised(){ @admin_api.get_oidc_integration_client_secret(**required_args) }
  end

  def test_get_oidc_integration_client_secret_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:integration_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_oidc_integration_client_secret() }
  end

  def test_reset_oidc_integration_client_secret
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {integration_key: 'INTEGRATIONKEY'}
    assert_nothing_raised(){ @admin_api.reset_oidc_integration_client_secret(**required_args) }
  end

  def test_reset_oidc_integration_client_secret_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:integration_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.reset_oidc_integration_client_secret() }
  end


  ##
  # Policies
  #
  def test_get_policies_summary
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_policies_summary() }
  end

  def test_get_policies
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_policies() }
  end

  def test_get_global_policy
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.get_global_policy() }
  end

  def test_get_policy
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {policy_key: 'POLICYKEY'}
    assert_nothing_raised(){ @admin_api.get_policy(**required_args) }
  end

  def test_get_policy_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:policy_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_policy() }
  end

  def test_calculate_policy
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {user_id: 'USERID', integration_key: 'INTEGRATIONKEY'}
    assert_nothing_raised(){ @admin_api.calculate_policy(**required_args) }
  end

  def test_calculate_policy_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id, :integration_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.calculate_policy() }
  end

  def test_copy_policy
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {policy_key: 'POLICYKEY'}
    assert_nothing_raised(){ @admin_api.copy_policy(**required_args) }
  end

  def test_copy_policy_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:policy_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.copy_policy() }
  end

  def test_create_policy
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {policy_name: 'POLICYNAME'}
    assert_nothing_raised(){ @admin_api.create_policy(**required_args) }
  end

  def test_create_policy_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:policy_name]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_policy() }
  end

  def test_update_policies
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {policies_to_update: ['POLICYKEY1'], policy_changes: {sections: {}}}
    assert_nothing_raised(){ @admin_api.update_policies(**required_args) }
  end

  def test_update_policies_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:policies_to_update, :policy_changes]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_policies() }
  end

  def test_update_policy
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {policy_key: 'POLICYKEY'}
    assert_nothing_raised(){ @admin_api.update_policy(**required_args) }
  end

  def test_update_policy_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:policy_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_policy() }
  end

  def test_delete_policy
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {policy_key: 'POLICYKEY'}
    assert_nothing_raised(){ @admin_api.delete_policy(**required_args) }
  end

  def test_delete_policy_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:policy_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_policy() }
  end


  ##
  # Endpoints
  #
  def test_get_endpoints
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_endpoints() }
  end

  def test_get_endpoint
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {epkey: 'EPKEY'}
    assert_nothing_raised(){ @admin_api.get_endpoint(**required_args) }
  end

  def test_get_endpoint_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:epkey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_endpoint() }
  end


  ##
  # Registered Devices
  #
  def test_get_registered_devices
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_registered_devices() }
  end

  def test_get_registered_device
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {compkey: 'COMPKEY'}
    assert_nothing_raised(){ @admin_api.get_registered_device(**required_args) }
  end

  def test_get_registered_device_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:compkey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_registered_device() }
  end

  def test_delete_registered_device
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {compkey: 'COMPKEY'}
    assert_nothing_raised(){ @admin_api.delete_registered_device(**required_args) }
  end

  def test_delete_registered_device_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:compkey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_registered_device() }
  end

  def test_get_blocked_registered_devices
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_blocked_registered_devices() }
  end

  def test_get_blocked_registered_device
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {compkey: 'COMPKEY'}
    assert_nothing_raised(){ @admin_api.get_blocked_registered_device(**required_args) }
  end

  def test_get_blocked_registered_device_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:compkey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_blocked_registered_device() }
  end

  def test_block_registered_devices
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {registered_device_key_list: ['REGISTEREDDEVICEKEY1']}
    assert_nothing_raised(){ @admin_api.block_registered_devices(**required_args) }
  end

  def test_block_registered_devices_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:registered_device_key_list]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.block_registered_devices() }
  end

  def test_block_registered_device
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {compkey: 'COMPKEY'}
    assert_nothing_raised(){ @admin_api.block_registered_device(**required_args) }
  end

  def test_block_registered_device_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:compkey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.block_registered_device() }
  end

  def test_unblock_registered_devices
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    required_args = {registered_device_key_list: ['REGISTEREDDEVICEKEY1']}
    assert_nothing_raised(){ @admin_api.unblock_registered_devices(**required_args) }
  end

  def test_unblock_registered_devices_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:registered_device_key_list]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.unblock_registered_devices() }
  end

  def test_unblock_registered_device
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {compkey: 'COMPKEY'}
    assert_nothing_raised(){ @admin_api.unblock_registered_device(**required_args) }
  end

  def test_unblock_registered_device_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:compkey]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.unblock_registered_device() }
  end


  ##
  # Passport
  #
  def test_get_passport_config
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_passport_config() }
  end

  def test_update_passport_config
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {disabled_groups: [], enabled_groups: [], enabled_status: 'enabled'}
    assert_nothing_raised(){ @admin_api.update_passport_config(**required_args) }
  end

  def test_update_passport_config_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:disabled_groups, :enabled_groups, :enabled_status]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_passport_config() }
  end


  ##
  # Administrators
  #
  def test_get_admins
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_admins() }
  end

  def test_create_admin
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {email: 'EMAIL', name: 'NAME'}
    assert_nothing_raised(){ @admin_api.create_admin(**required_args) }
  end

  def test_create_admin_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:email, :name]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_admin() }
  end

  def test_get_admin
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.get_admin(**required_args) }
  end

  def test_get_admin_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_admin() }
  end

  def test_update_admin
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.update_admin(**required_args) }
  end

  def test_update_admin_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_admin() }
  end

  def test_delete_admin
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.delete_admin(**required_args) }
  end

  def test_delete_admin_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_admin() }
  end

  def test_reset_admin_auth_attempts
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.reset_admin_auth_attempts(**required_args) }
  end

  def test_reset_admin_auth_attempts_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.reset_admin_auth_attempts() }
  end

  def test_clear_admin_inactivity
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.clear_admin_inactivity(**required_args) }
  end

  def test_clear_admin_inactivity_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.clear_admin_inactivity() }
  end

  def test_create_existing_admin_activation_link
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.create_existing_admin_activation_link(**required_args) }
  end

  def test_create_existing_admin_activation_link_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_existing_admin_activation_link() }
  end

  def test_delete_existing_admin_activation_link
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.delete_existing_admin_activation_link(**required_args) }
  end

  def test_delete_existing_admin_activation_link_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_existing_admin_activation_link() }
  end

  def test_email_existing_admin_activation_link
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.email_existing_admin_activation_link(**required_args) }
  end

  def test_email_existing_admin_activation_link_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.email_existing_admin_activation_link() }
  end

  def test_create_new_admin_activation_link
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {email: 'EMAIL'}
    assert_nothing_raised(){ @admin_api.create_new_admin_activation_link(**required_args) }
  end

  def test_create_new_admin_activation_link_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:email]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_new_admin_activation_link() }
  end

  def test_get_new_admin_pending_activations
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_new_admin_pending_activations() }
  end

  def test_delete_new_admin_pending_activations
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {admin_activation_id: 'ADMINACTIVATIONID'}
    assert_nothing_raised(){ @admin_api.delete_new_admin_pending_activations(**required_args) }
  end

  def test_delete_new_admin_pending_activations_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_activation_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_new_admin_pending_activations() }
  end

  def test_sync_admin
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {directory_key: 'DIRECTORYKEY', email: 'EMAIL'}
    assert_nothing_raised(){ @admin_api.sync_admin(**required_args) }
  end

  def test_sync_admin_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:directory_key, :email]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.sync_admin() }
  end

  def test_get_admin_password_mgmt_statuses
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_admin_password_mgmt_statuses() }
  end

  def test_get_admin_password_mgmt_status
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.get_admin_password_mgmt_status(**required_args) }
  end

  def test_get_admin_password_mgmt_status_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_admin_password_mgmt_status() }
  end

  def test_update_admin_password_mgmt_status
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.update_admin_password_mgmt_status(**required_args) }
  end

  def test_update_admin_password_mgmt_status_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_admin_password_mgmt_status() }
  end

  def test_get_admin_allowed_auth_factors
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.get_admin_allowed_auth_factors() }
  end

  def test_update_admin_allowed_auth_factors
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.update_admin_allowed_auth_factors() }
  end


  ##
  # Administrative Units
  #
  def test_get_administrative_units
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_administrative_units() }
  end

  def test_get_administrative_unit
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_unit_id: 'ADMINUNITID'}
    assert_nothing_raised(){ @admin_api.get_administrative_unit(**required_args) }
  end

  def test_get_administrative_unit_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_unit_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_administrative_unit() }
  end

  def test_create_administrative_unit
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {name: 'NAME', description: 'DESCRIPTION', restrict_by_groups: false}
    assert_nothing_raised(){ @admin_api.create_administrative_unit(**required_args) }
  end

  def test_create_administrative_unit_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:name, :description, :restrict_by_groups]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.create_administrative_unit() }
  end

  def test_update_administrative_unit
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_unit_id: 'ADMINUNITID'}
    assert_nothing_raised(){ @admin_api.update_administrative_unit(**required_args) }
  end

  def test_update_administrative_unit_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_unit_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_administrative_unit() }
  end

  def test_add_administrative_unit_admin
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_unit_id: 'ADMINUNITID', admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.add_administrative_unit_admin(**required_args) }
  end

  def test_add_administrative_unit_admin_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_unit_id, :admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.add_administrative_unit_admin() }
  end

  def test_remove_administrative_unit_admin
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_unit_id: 'ADMINUNITID', admin_id: 'ADMINID'}
    assert_nothing_raised(){ @admin_api.remove_administrative_unit_admin(**required_args) }
  end

  def test_remove_administrative_unit_admin_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_unit_id, :admin_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.remove_administrative_unit_admin() }
  end

  def test_add_administrative_unit_group
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_unit_id: 'ADMINUNITID', group_id: 'GROUPID'}
    assert_nothing_raised(){ @admin_api.add_administrative_unit_group(**required_args) }
  end

  def test_add_administrative_unit_group_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_unit_id, :group_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.add_administrative_unit_group() }
  end

  def test_remove_administrative_unit_group
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_unit_id: 'ADMINUNITID', group_id: 'GROUPID'}
    assert_nothing_raised(){ @admin_api.remove_administrative_unit_group(**required_args) }
  end

  def test_remove_administrative_unit_group_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_unit_id, :group_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.remove_administrative_unit_group() }
  end

  def test_add_administrative_unit_integration
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_unit_id: 'ADMINUNITID', integration_key: 'INTEGRATIONKEY'}
    assert_nothing_raised(){ @admin_api.add_administrative_unit_integration(**required_args) }
  end

  def test_add_administrative_unit_integration_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_unit_id, :integration_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.add_administrative_unit_integration() }
  end

  def test_remove_administrative_unit_integration
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {admin_unit_id: 'ADMINUNITID', integration_key: 'INTEGRATIONKEY'}
    assert_nothing_raised(){ @admin_api.remove_administrative_unit_integration(**required_args) }
  end

  def test_remove_administrative_unit_integration_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_unit_id, :integration_key]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.remove_administrative_unit_integration() }
  end

  def test_delete_administrative_unit
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {admin_unit_id: 'ADMINUNITID'}
    assert_nothing_raised(){ @admin_api.delete_administrative_unit(**required_args) }
  end

  def test_delete_administrative_unit_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:admin_unit_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.delete_administrative_unit() }
  end


  ##
  # Logs
  #
  def test_get_authentication_logs
    @mock_http.expects(:request).returns(@authlogs_ok_resp)
    required_args = {mintime: 123456789000, maxtime: 987654321000}
    assert_nothing_raised(){ @admin_api.get_authentication_logs(**required_args) }
  end

  def test_get_authentication_logs_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:mintime, :maxtime]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_authentication_logs() }
  end

  def test_get_activity_logs
    @mock_http.expects(:request).returns(@items_ok_resp)
    required_args = {mintime: 123456789000, maxtime: 987654321000}
    assert_nothing_raised(){ @admin_api.get_activity_logs(**required_args) }
  end

  def test_get_activity_logs_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:mintime, :maxtime]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_activity_logs() }
  end

  def test_get_admin_logs
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_admin_logs() }
  end

  def test_get_telephony_logs
    @mock_http.expects(:request).returns(@items_ok_resp)
    required_args = {mintime: 123456789000, maxtime: 987654321000}
    assert_nothing_raised(){ @admin_api.get_telephony_logs(**required_args) }
  end

  def test_get_telephony_logs_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:mintime, :maxtime]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_telephony_logs() }
  end

  def test_get_offline_enrollment_logs
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_offline_enrollment_logs() }
  end


  ##
  # Trust Monitor
  #

  def test_get_trust_monitor_events
    @mock_http.expects(:request).returns(@events_ok_resp)
    required_args = {mintime: 123456789000, maxtime: 987654321000}
    assert_nothing_raised(){ @admin_api.get_trust_monitor_events(**required_args) }
  end

  def test_get_trust_monitor_events_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:mintime, :maxtime]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.get_trust_monitor_events() }
  end


  ##
  # Settings
  #
  def test_get_settings
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.get_settings() }
  end

  def test_update_settings
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.update_settings() }
  end

  def test_get_logo
    @mock_http.expects(:request).returns(@image_ok_resp)
    assert_nothing_raised(){ @admin_api.get_logo() }
  end

  def test_update_logo
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    required_args = {logo: 'LOGO'}
    assert_nothing_raised(){ @admin_api.update_logo(**required_args) }
  end

  def test_update_logo_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:logo]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.update_logo() }
  end

  def test_delete_logo
    @mock_http.expects(:request).returns(@json_ok_str_resp)
    assert_nothing_raised(){ @admin_api.delete_logo() }
  end


  ##
  # Custom Branding
  #
  def test_get_custom_branding
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.get_custom_branding() }
  end

  def test_update_custom_branding
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.update_custom_branding() }
  end

  def test_get_custom_branding_draft
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.get_custom_branding_draft() }
  end

  def test_update_custom_branding_draft
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.update_custom_branding_draft() }
  end

  def test_add_custom_branding_draft_user
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.add_custom_branding_draft_user(**required_args) }
  end

  def test_add_custom_branding_draft_user_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.add_custom_branding_draft_user() }
  end

  def test_remove_custom_branding_draft_user
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    required_args = {user_id: 'USERID'}
    assert_nothing_raised(){ @admin_api.remove_custom_branding_draft_user(**required_args) }
  end

  def test_remove_custom_branding_draft_user_args_missing
    @mock_http.expects(:request).times(0)
    required_args = [:user_id]
    assert_raise_with_message(
      ArgumentError,
      missing_keywords_message(required_args)
    ){ @admin_api.remove_custom_branding_draft_user() }
  end

  def test_publish_custom_branding_draft
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.publish_custom_branding_draft() }
  end

  def test_get_custom_branding_messaging
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.get_custom_branding_messaging() }
  end

  def test_update_custom_branding_messaging
    @mock_http.expects(:request).returns(@json_ok_hsh_resp)
    assert_nothing_raised(){ @admin_api.update_custom_branding_messaging() }
  end


  ##
  # Account Info
  #
  def test_get_account_info_summary
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_account_info_summary() }
  end

  def test_get_telephony_credits_used_report
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_telephony_credits_used_report() }
  end

  def test_get_authentication_attempts_report
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_authentication_attempts_report() }
  end

  def test_get_user_authentication_attempts_report
    @mock_http.expects(:request).returns(@json_ok_arr_resp)
    assert_nothing_raised(){ @admin_api.get_user_authentication_attempts_report() }
  end
end
