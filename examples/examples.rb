# frozen_string_literal: true

require_relative 'duo_api'

IKEY = ARGV[0]
SKEY = ARGV[1]
HOST = ARGV[2]
abort "Usage: #{$PROGRAM_NAME} IKEY SKEY HOST" unless HOST

# Initialize the api
client = DuoApi.new IKEY, SKEY, HOST

# EXAMPLE 1: Get the first 100 users
resp = client.request('GET', '/admin/v1/users', { limit: '100', offset: '0' })

# print out some info from the response
puts resp.code
puts resp.header.to_hash
puts resp.message
puts resp.http_version
puts resp.body

# EXAMPLE 2: retreive the user 'john'
resp2 = client.request('GET', '/admin/v1/users', { username: 'john' })
puts resp2.body

# EXAMPLE 3: create a new user
resp3 = client.request('POST', '/admin/v1/users', { username: 'john2' })
puts resp3.body

# EXAMPLE 4: delete user with user_id: 'DUAE0W526W52YHOBMDO6'
resp4 = client.request('DELETE', '/admin/v1/users/DUAE0W526W52YHOBMDO6')
puts resp4.body

# EXAMPLE 5: Authlog V2. Pagination with next_offset.
resp5 = client.request('GET', '/admin/v2/logs/authentication',
                       { limit: '1', mintime: '1546371049194', maxtime: '1548963049000' })
puts resp5.body
resp6 = client.request('GET', '/admin/v2/logs/authentication',
                       { limit: '1', mintime: '1546371049194', maxtime: '1548963049000',
                         next_offset: result['response']['metadata']['next_offset'] })
puts resp6.body
