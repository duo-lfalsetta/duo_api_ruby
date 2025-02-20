require_relative 'common'


class TestHelpersPaginated < TestCase
  def setup
    super
    @mock_http = mock()
    Net::HTTP.expects(:start).at_least_once.yields(@mock_http)

    @standard_paged_response_1 = MockResponse.new(
      '200',
      {
        stat: 'OK',
        response: [ 'RESPONSE1', 'RESPONSE2' ],
        metadata: {
          total_objects: 4,
          next_offset: 2,
          prev_offset: 0
        }
      },
      {'Content-Type' => 'application/json'}
    )

    @standard_paged_response_2 = MockResponse.new(
      '200',
      JSON.generate({
        stat: 'OK',
        response: [ 'RESPONSE3', 'RESPONSE4' ],
        metadata: {
          total_objects: 4,
          prev_offset: 2
        }
      }),
      {'Content-Type' => 'application/json'}
    )

    @standard_paged_combined_results = stringify_hash_keys({
      stat: 'OK',
      response: [ 'RESPONSE1', 'RESPONSE2', 'RESPONSE3', 'RESPONSE4' ],
      metadata: {
        total_objects: 4,
        prev_offset: 2
      }
    })

    @nonstandard_paged_response_1 = MockResponse.new(
      '200',
      JSON.generate({
        stat: 'OK',
        response: {
          items: [ 'RESPONSE1', 'RESPONSE2' ],
          metadata: {
            next_offset: ['1738997429000', 'cb306faf-7f36-494d-9a0e-5697d93331f8']
          }
        }
      }),
      {'Content-Type' => 'application/json'}
    )

    @nonstandard_paged_response_2 = MockResponse.new(
      '200',
      JSON.generate({
        stat: 'OK',
        response: {
          items: [ 'RESPONSE3', 'RESPONSE4' ],
          metadata: {}
        }
      }),
      {'Content-Type' => 'application/json'}
    )

    @nonstandard_paged_combined_results = stringify_hash_keys({
      stat: 'OK',
      response: {
        items: [ 'RESPONSE1', 'RESPONSE2', 'RESPONSE3', 'RESPONSE4' ],
        metadata: {}
      }
    })
  end


  def test_get_all_standard_paged_ok
    @mock_http.expects(:request).twice.returns(
      @standard_paged_response_1, @standard_paged_response_2)
    actual_response = @client.get_all('/fake')
    assert_equal(@standard_paged_combined_results, actual_response)
  end

  def test_get_all_nonstandard_paged_ok
    @mock_http.expects(:request).twice.returns(
      @nonstandard_paged_response_1, @nonstandard_paged_response_2)
    actual_response = @client.get_all('/fake',
                                      data_array_path: ['response', 'items'],
                                      metadata_path: ['response', 'metadata'])
    assert_equal(@nonstandard_paged_combined_results, actual_response)
  end

  def test_get_all_bad_data_array_path
    @mock_http.expects(:request).returns(@nonstandard_paged_response_1)
    assert_raise_with_message(
      DuoApi::PaginationError,
      'Object at data_array_path ["response"] is not an Array'){
        @client.get_all('/fake', metadata_path: ['response', 'metadata'])}
  end
  
#  def test_get_all_bad_metadata_path
#    @mock_http.expects(:request).returns(@nonstandard_paged_response_1)
#    assert_raise_with_message(
#      DuoApi::PaginationError,
#      'Object at data_array_path ["response"] is not an Array'){
#        @client.get_all('/fake', data_array_path: ['response', 'items'])}
#  end
end
