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
  attr_reader :code
  attr_reader :body
  attr_reader :headers

  def initialize(code, body = nil, headers = {})
    @code = code.to_s
    @body = body.is_a?(Hash) ? JSON.generate(body) : body
    @headers = headers.transform_keys{|k| k.to_s.downcase.to_sym}
  end

  def [](key)
    standardized_key = key.to_s.downcase.to_sym
    headers[standardized_key]
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


def json_to_sym_hash(json)
  JSON.parse(json, symbolize_names: true)
end
