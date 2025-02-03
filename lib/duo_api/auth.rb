require_relative 'client'

class DuoApi
  class Auth < DuoApi
    def ping()
      get('/auth/v2/ping')['response']
    end

    def check()
      get('/auth/v2/check')['response']
    end
  end
end
