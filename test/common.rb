require 'test/unit'
require 'mocha/test_unit'

require 'duo_api'

IKEY = 'test_ikey'
SKEY = 'gtdfxv9YgVBYcF6dl2Eq17KUQJN2PLM2ODVTkvoT'
HOST = 'foO.BAr52.cOm'


class BaseTestCase < Test::Unit::TestCase
  def setup()
    @client = DuoApi.new(IKEY, SKEY, HOST)
  end
end

class HTTPTestCase < BaseTestCase
  setup
  def setup_http()
    @mock_http = mock()
    Net::HTTP.expects(:start).times(0..2).yields(@mock_http)
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


# Get rid of backtraces on errors for tests
class StandardError
  def backtrace
    []
  end
end


# Parse JSON string to Hash with symbol keys
def parse_json_to_sym_hash(json)
  JSON.parse(json, symbolize_names: true)
end

# Format ArgumentError messages for missing keywords
def missing_keywords_message(required_keywords)
  return if required_keywords.count < 1
  msg = 'missing keyword'
  msg += 's' if required_keywords.count > 1
  msg += ": :#{required_keywords.join(', :')}"
  msg
end
