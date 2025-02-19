require 'test/unit'
require 'mocha/test_unit'

require 'duo_api'

IKEY = 'test_ikey'
SKEY = 'gtdfxv9YgVBYcF6dl2Eq17KUQJN2PLM2ODVTkvoT'
HOST = 'foO.BAr52.cOm'


class TestCase < Test::Unit::TestCase
  def setup
    @client = DuoApi.new(IKEY, SKEY, HOST)
  end
end

class MockResponse < Object
  attr_accessor :code
  attr_accessor :body
  attr_accessor :headers

  def initialize(code, body = nil, headers = {})
    @code = code.to_s
    @body = body
    @headers = headers.transform_keys(&:to_s)
  end

  def [](key)
    stringkey = key.to_s
    headers[stringkey]
  end

  def []=(key)
    stringkey = key.to_s
    headers[stringkey]
  end

  def to_hash()
    headers
  end

  def to_s()
    [
      'HTTP Status Code:', self.code,
      'HTTP Headers:', self.headers,
      'HTTP Body:', self.body
    ].join("\n")
  end
end
