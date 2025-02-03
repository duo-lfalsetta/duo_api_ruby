require_relative 'client'

class DuoApi
  class Admin < DuoApi
    def get_integrations()
      get_all('/admin/v2/integrations')['response']
    end

    def get_users()
      get_all('/admin/v1/users')['response']
    end
  end
end
