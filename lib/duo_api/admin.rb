require_relative 'client'
require_relative 'util'

class DuoApi
  class Admin < DuoApi
    
    ###
    # Users
    #
    def get_users(**optional_params)
      # optional_params: username, email, user_id_list, username_list
      get_all('/admin/v1/users', optional_params)['response']
    end
    def create_user(username:, **optional_params)
      # optional_params: alias1, alias2, alias3, alias4, aliases, realname, email,
      #                  enable_auto_prompt, status, notes, firstname, lastname
      params = optional_params.merge({username: username})
      post('/admin/v1/users', params)['response']
    end
    def bulk_create_users(users:)
      # Each user hash in users array requires :username and has the same optional params
      # as create_user()
      serialized_users = JSON.generate(users)
      params = {users: serialized_users}
      post('/admin/v1/users/bulk_create', params)['response']
    end
    def bulk_restore_users(user_id_list:)
      params = {user_id_list: user_id_list}
      post('/admin/v1/users/bulk_restore', params)['response']
    end
    def bulk_trash_users(user_id_list:)
      params = {user_id_list: user_id_list}
      post('/admin/v1/users/bulk_send_to_trash', params)['response']
    end
    def get_user(user_id:)
      get("/admin/v1/users/#{user_id}")['response']
    end
    def update_user(user_id:, **optional_params)
      # optional_params: alias1, alias2, alias3, alias4, aliases, realname, email,
      #                  enable_auto_prompt, status, notes, firstname, lastname,
      #                  username
      post("/admin/v1/users/#{user_id}", optional_params)['response']
    end
    def delete_user(user_id:)
      delete("/admin/v1/users/#{user_id}")['response']
    end
    def enroll_user(username:, email:, **optional_params)
      # optional_params: valid_secs
      params = optional_params.merge({username: username, email: email})
      post('/admin/v1/users/enroll', params)['response']
    end
    def create_user_bypass_codes(user_id:, **optional_params)
      # optional_params: count, codes, preserve_existing, reuse_count, valid_secs
      post("/admin/v1/users/#{user_id}/bypass_codes", optional_params)['response']
    end
    def get_user_bypass_codes(user_id:)
      get_all("/admin/v1/users/#{user_id}/bypass_codes")['response']
    end
    def get_user_groups(user_id:)
      get_all("/admin/v1/users/#{user_id}/groups")['response']
    end
    def add_user_group(user_id:, group_id:)
      params = {group_id: group_id}
      post("/admin/v1/users/#{user_id}/groups", params)['response']
    end
    def remove_user_group(user_id:, group_id:)
      delete("/admin/v1/users/#{user_id}/groups/#{group_id}")['response']
    end
    def get_user_phones(user_id:)
      get_all("/admin/v1/users/#{user_id}/phones")['response']
    end
    def add_user_phone(user_id:, phone_id:)
      params = {phone_id: phone_id}
      post("/admin/v1/users/#{user_id}/phones", params)['response']
    end
    def remove_user_phone(user_id:, phone_id:)
      delete("/admin/v1/users/#{user_id}/phones/#{phone_id}")['response']
    end
    def get_user_hardware_tokens(user_id:)
      get_all("/admin/v1/users/#{user_id}/tokens")['response']
    end
    def add_user_hardware_token(user_id:, token_id:)
      params = {token_id: token_id}
      post("/admin/v1/users/#{user_id}/tokens", params)['response']
    end
    def remove_user_hardware_token(user_id:, token_id:)
      delete("/admin/v1/users/#{user_id}/tokens/#{token_id}")['response']
    end
    def get_user_webauthn_credentials(user_id:)
      get_all("/admin/v1/users/#{user_id}/webauthncredentials")['response']
    end
    def get_user_desktop_authenticators(user_id:)
      get_all("/admin/v1/users/#{user_id}/desktopauthenticators")['response']
    end
    def sync_user(username:, directory_key:)
      params = {username: username}
      post("/admin/v1/users/directorysync/#{directory_key}/syncuser", params)['response']
    end
    def send_verification_push(user_id:, phone_id:)
      params = {phone_id: phone_id}
      post("/admin/v1/users/#{user_id}/send_verification_push", params)['response']
    end
    def get_verification_push_response(user_id:, push_id:)
      params = {push_id: push_id}
      get("/admin/v1/users/#{user_id}/verification_push_response", params)['response']
    end
    
    
    ###
    # Bulk Operations
    #
    def bulk_operations(operations:)
      # Each hash in user_operations array requires :method, :path, and :body
      # Each :body has the same parameter requirements as the individual operation
      # Supported operations:
      #   Create User:       POST /admin/v1/users
      #   Modify User:       POST /admin/v1/users/[user_id]
      #   Delete User:     DELETE /admin/v1/users/[user_id]
      #   Add User Group:    POST /admin/v1/users/[user_id]/groups
      #   Remove User Group: POST /admin/v1/users/[user_id]/groups/[group_id]
      serialized_operations = JSON.generate(operations)
      params = {operations: serialized_operations}
      post('/admin/v1/bulk', params)['response']
    end


    ###
    # Groups
    #
    def get_groups(**optional_params)
      # optional_params: group_id_list
      get_all('/admin/v1/groups', optional_params)['response']
    end
    def create_group(name:, **optional_params)
      # optional_params: desc, status
      params = optional_params.merge({name: name})
      post('/admin/v1/groups', params)['response']
    end
    def get_group(group_id:)
      get("/admin/v1/groups/#{group_id}")['response']
    end
    def get_group_users(group_id:)
      get_all("/admin/v1/groups/#{group_id}/users")['response']
    end
    def update_group(group_id:, **optional_params)
      # optional_params: desc, status, name
      post("/admin/v1/groups/#{group_id}", optional_params)['response']
    end
    def delete_group(group_id:)
      delete("/admin/v1/groups/#{group_id}")['response']
    end


    ###
    # Phones
    #
    def get_phones(**optional_params)
      # optional_params: number, extension
      get_all('/admin/v1/phones', optional_params)['response']
    end
    def create_phone(**optional_params)
      # optional_params: number, name, extension, type, platform, predelay, postdelay
      post('/admin/v1/phones', optional_params)['response']
    end
    def get_phone(phone_id:)
      get("/admin/v1/phones/#{phone_id}")['response']
    end
    def update_phone(phone_id:, **optional_params)
      # optional_params: number, name, extension, type, platform, predelay, postdelay
      post("/admin/v1/phones/#{phone_id}", optional_params)['response']
    end
    def delete_phone(phone_id:)
      delete("/admin/v1/phones/#{phone_id}")['response']
    end
    def create_activation_url(phone_id:, **optional_params)
      # optional_params: valid_secs, install
      post("/admin/v1/phones/#{phone_id}/activation_url", optional_params)['response']
    end
    def send_sms_activation(phone_id:, **optional_params)
      # optional_params: valid_secs, install, installation_msg, activation_msg
      post("/admin/v1/phones/#{phone_id}/send_sms_activation", optional_params)['response']
    end
    def send_sms_installation(phone_id:, **optional_params)
      # optional_params: installation_msg
      post("/admin/v1/phones/#{phone_id}/send_sms_installation", optional_params)['response']
    end
    def send_sms_passcodes(phone_id:)
      post("/admin/v1/phones/#{phone_id}/send_sms_passcodes")['response']
    end


    ###
    # Tokens
    #
    def get_tokens(**optional_params)
      # optional_params: type, serial
      get_all('/admin/v1/tokens', optional_params)['response']
    end
    def create_token(type:, serial:, **optional_params)
      # optional_params: secret, counter, private_id, aes_key
      params = optional_params.merge({type: type, serial: serial})
      post('/admin/v1/tokens', params)['response']
    end
    def get_token(token_id:)
      get("/admin/v1/tokens/#{token_id}")['response']
    end
    def resync_token(token_id:, code1:, code2:, code3:)
      params = {code1: code1, code2: code2, code3: code3}
      post("/admin/v1/tokens/#{token_id}/resync", params)['response']
    end
    def delete_token(token_id:)
      delete("/admin/v1/tokens/#{token_id}")['response']
    end


    ###
    # WebAuthn Credentials
    #
    def get_webauthncredentials()
      get_all('/admin/v1/webauthncredentials')['response']
    end
    def get_webauthncredential(webauthnkey:)
      get("/admin/v1/webauthncredentials/#{webauthnkey}")['response']
    end
    def delete_webauthncredential(webauthnkey:)
      delete("/admin/v1/webauthncredentials/#{webauthnkey}")['response']
    end


    ###
    # Desktop Authenticators
    #
    def get_desktop_authenticators()
      get_all('/admin/v1/desktop_authenticators')['response']
    end
    def get_desktop_authenticator(dakey:)
      get("/admin/v1/desktop_authenticators/#{dakey}")['response']
    end
    def delete_desktop_authenticator(dakey:)
      delete("/admin/v1/desktop_authenticators/#{dakey}")['response']
    end
    def get_shared_desktop_authenticators()
      get_all('/admin/v1/desktop_authenticators/shared_device_auth')['response']
    end
    def get_shared_desktop_authenticator(shared_device_key:)
      get("/admin/v1/desktop_authenticators/shared_device_auth/#{shared_device_key}")['response']
    end
    def create_shared_desktop_authenticator(group_id_list:, trusted_endpoint_integration_id_list:,
                                            **optional_params)
      # optional_params: active, name
      params = optional_params.merge({
        group_id_list: group_id_list,
        trusted_endpoint_integration_id_list: trusted_endpoint_integration_id_list})
      post('/admin/v1/desktop_authenticators/shared_device_auth', params)['response']
    end
    def update_shared_desktop_authenticator(shared_device_key:, **optional_params)
      # optional_params: active, name, group_id_list, trusted_endpoint_integration_id_list
      put("/admin/v1/desktop_authenticators/shared_device_auth/#{shared_device_key}",
          optional_params)['response']
    end
    def delete_shared_desktop_authenticator(shared_device_key:)
      delete("/admin/v1/desktop_authenticators/shared_device_auth/#{shared_device_key}")['response']
    end


    ###
    # Bypass Codes
    #
    def get_bypass_codes()
      get_all('/admin/v1/bypass_codes')['response']
    end
    def get_bypass_code(bypass_code_id:)
      get("/admin/v1/bypass_codes/#{bypass_code_id}")['response']
    end
    def delete_bypass_code(bypass_code_id:)
      delete("/admin/v1/bypass_codes/#{bypass_code_id}")['response']
    end


    ###
    # Integrations
    #
    def get_integrations()
      get_all('/admin/v2/integrations')['response']
    end
    def create_integration(name:, type:, **optional_params)
      # optional_params: adminapi_admins, adminapi_admins_read, adminapi_allow_to_set_permissions,
      #                  adminapi_info, adminapi_integrations, adminapi_read_log,
      #                  adminapi_read_resource, adminapi_settings, adminapi_write_resource,
      #                  enroll_policy, greeting, groups_allowed, ip_whitelist,
      #                  ip_whitelist_enroll_policy, networks_for_api_access, notes,
      #                  trusted_device_days, self_service_allowed, sso, username_normalization_policy
      #
      #      sso params: https://duo.com/docs/adminapi#sso-parameters
      params = optional_params.merge({name: name, type: type})
      post('/admin/v2/integrations', params)['response']
    end
    def get_integration(integration_key:)
      get("/admin/v2/integrations/#{integration_key}")['response']
    end
    def update_integration(integration_key:, **optional_params)
      # optional_params: adminapi_admins, adminapi_admins_read, adminapi_allow_to_set_permissions,
      #                  adminapi_info, adminapi_integrations, adminapi_read_log,
      #                  adminapi_read_resource, adminapi_settings, adminapi_write_resource,
      #                  enroll_policy, greeting, groups_allowed, ip_whitelist,
      #                  ip_whitelist_enroll_policy, networks_for_api_access, notes,
      #                  trusted_device_days, self_service_allowed, sso, username_normalization_policy,
      #                  name, policy_key, prompt_v4_enabled, reset_secret_key
      #
      #      sso params: https://duo.com/docs/adminapi#sso-parameters
      post("/admin/v2/integrations/#{integration_key}", optional_params)['response']
    end
    def delete_integration(integration_key:)
      delete("/admin/v2/integrations/#{integration_key}")['response']
    end
    def get_integration_secret_key(integration_key:)
      get("/admin/v2/integrations/#{integration_key}/skey")['response']
    end
    def get_oauth_integration_client_secret(integration_key:, client_id:)
      get("/admin/v2/integrations/oauth_cc/#{integration_key}/client_secret/#{client_id}")['response']
    end
    def reset_oauth_integration_client_secret(integration_key:, client_id:)
      post("/admin/v2/integrations/oauth_cc/#{integration_key}/client_secret/#{client_id}")['response']
    end
    def get_oidc_integration_client_secret(integration_key:)
      get("/admin/v2/integrations/oidc/#{integration_key}/client_secret")['response']
    end
    def reset_oidc_integration_client_secret(integration_key:)
      post("/admin/v2/integrations/oidc/#{integration_key}/client_secret")['response']
    end


    ###
    # Policies
    #
    def get_policies_summary()
      get('/admin/v2/policies/summary')['response']
    end
    def get_policies()
      get_all('/admin/v2/policies')['response']
    end
    def get_policy(policy_key:)
      get("/admin/v2/policies/#{policy_key}")['response']
    end
    def calculate_policy(user_id:, integration_key:)
      params = {user_id: user_id, integration_key: integration_key}
      get('/admin/v2/policies/calculate', params)['response']
    end
    def copy_policy(policy_key:, **optional_params)
      # optional_params: new_policy_names_list
      params = optional_params.merge({policy_key: policy_key})
      post('/admin/v2/policies/copy', params)['response']
    end
    def create_policy(policy_name:, **optional_params)
      # optional_params: apply_to_apps, apply_to_groups_in_apps, sections
      params = optional_params.merge({policy_name: policy_name})
      post('/admin/v2/policies', params)['response']
    end
    def update_policies(policies_to_update:, policy_changes:)
      # parameter formatting: https://duo.com/docs/adminapi#update-policies
      params = {policies_to_update: policies_to_update, policy_changes: policy_changes}
      put('/admin/v2/policies/update', params)['response']
    end
    def update_policy(policy_key:, **optional_params)
      # optional_params: apply_to_apps, apply_to_groups_in_apps, sections,
      #                  policy_name, sections_to_delete
      params = optional_params.merge({policy_key: policy_key})
      put("/admin/v2/policies/#{policy_key}", params)['response']
    end
    def delete_policy(policy_key:)
      delete("/admin/v2/policies/#{policy_key}")['response']
    end


    ###
    # Endpoints
    #


    ###
    # Registered Devices
    #


    ###
    # Passport
    #


    ###
    # Administrators
    #


    ###
    # Administrative Units
    #


    ###
    # Logs
    #


    ###
    # Trust Monitor
    #


    ###
    # Settings
    #


    ###
    # Custom Branding
    #


    ###
    # Account Info
    #


  end
end
