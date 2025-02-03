require_relative 'client'

class DuoApi
  class Accounts < DuoApi
    def get_child_accounts()
      post('/accounts/v1/account/list')['response']
    end
  end
end
