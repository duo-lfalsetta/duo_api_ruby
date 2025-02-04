require_relative 'client'

class DuoApi
  class Admin < DuoApi
    ###
    # Users
    #
    def get_users()
      get_all('/admin/v1/users')['response']
    end
    def get_user(user_id)
      get("/admin/v1/users/#{user_id}")['response']
    end
    def get_user_groups(user_id)
      get_all("/admin/v1/users/#{user_id}/groups")['response']
    end
    def get_user_bypass_codes(user_id)
      get_all("/admin/v1/users/#{user_id}/bypass_codes")['response']
    end
    def get_user_phones(user_id)
      get_all("/admin/v1/users/#{user_id}/phones")['response']
    end
    def get_user_hardware_tokens(user_id)
      get_all("/admin/v1/users/#{user_id}/tokens")['response']
    end
    def get_user_webauthn_credentials(user_id)
      get_all("/admin/v1/users/#{user_id}/webauthncredentials")['response']
    end
    def get_user_desktop_authenticators(user_id)
      get_all("/admin/v1/users/#{user_id}/desktopauthenticators")['response']
    end

    ###
    # Groups
    #
    
    ###
    # Tokens
    #

    ###
    # WebAuthn Credentials
    #

    ###
    # Desktop Authenticators
    #

    ###
    # Bypass Codes
    #

    ###
    # Integrations
    #
    def get_integrations()
      get_all('/admin/v2/integrations')['response']
    end

    ###
    # Policies
    #

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

    ###
    # Bulk Operations
    #

  end
end
