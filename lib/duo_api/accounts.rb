require_relative 'client'
require_relative 'helpers'

require_relative 'admin'


class DuoApi
  class Accounts < DuoApi

    ###
    # Accounts API
    #
    def get_child_accounts()
      post('/accounts/v1/account/list')['response']
    end

    def create_child_account(name:)
      post('/accounts/v1/account/create')['response']
    end

    def delete_child_account(account_id:)
      post('/accounts/v1/account/delete')['response']
    end


    ###
    # Child Account Admin API Wrapper
    #
    def admin_api(child_account_id:)
      child_account = get_child_accounts().select{|a| a['account_id'] == child_account_id}.first
      raise "Child account #{child_account_id} not found" unless child_account
      client = DuoApi::Admin.new(@ikey, @skey, child_account['api_hostname'], @proxy_str,
                                 ca_file: @ca_file, default_params: {account_id: child_account_id})

      # Additional Child Account Admin API Methods
      #
      # Note:
      #   - These are enabled by support request only
      #   - They can only be called by the DuoApi::Admin instance returned by this wrapper method
      #   - account_id is required for each of these, but it is provided by the client default_params
      #
      client.instance_eval do
        def get_edition()
          get('/admin/v1/billing/edition')['response']
        end

        def set_edition(edition:)
          params = {edition: edition}
          post('/admin/v1/billing/edition', params)['response']
        end

        def get_telephony_credits()
          get('/admin/v1/billing/telephony_credits')['response']
        end

        def set_telephony_credits(credits:)
          params = {credits: credits}
          post('/admin/v1/billing/telephony_credits', params)['response']
        end
      end

      client
    end

  end
end
