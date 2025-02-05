require_relative 'client'
require_relative 'util'

class DuoApi
  class Accounts < DuoApi
    def get_child_accounts()
      post('/accounts/v1/account/list')['response']
    end
  end
end
