require_relative 'client'
require_relative 'util'

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
    # Admin API Wrapper
    #
    def admin_api_call(account_id:, api_hostname:, api_method:, **admin_method_params)
      DuoApi::Admin.new(@ikey, @skey, api_hostname, @proxy_str, ca_file: @ca_file).send(
        api_method, account_id: account_id, **admin_method_params)
    end


    ###
    # Additional Admin API Methods
    #
    def get_edition(account_id:)
      params = {account_id: account_id}
      get('/admin/v1/billing/edition', params)['response']
    end

    def set_edition(account_id:, edition:)
      params = {account_id: account_id, edition: edition}
      post('/admin/v1/billing/edition', params)['response']
    end

    def get_telephony_credits(account_id:)
      params = {account_id: account_id}
      get('/admin/v1/billing/telephony_credits', params)['response']
    end

    def set_telephony_credits(account_id:, credits:)
      params = {account_id: account_id, credits: credits}
      post('/admin/v1/billing/telephony_credits', params)['response']
    end

  end
end
