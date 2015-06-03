require 'grape'
require 'pg'
require 'json'

class MyAPI < Grape::API
	
	version 'v1'

	format :json
	
	get '/hello' do
      		{ hello: 'world!' }
    	end
	get '/' do
		#"Hello lil yana tonsing"
		# Output a table of current connections to the DB

		conn = PG.connect( dbname: 'dbj5oivnhlc7j',
			host: 'ec2-174-129-26-115.compute-1.amazonaws.com',
			port:5432,
			user: 'tnuzcdcxwqpfii',
			password: 'uozKzNoRYYobqG-ENqzccvaqwB'	
		)
		arr = Array.new
		conn.exec( "SELECT * FROM users" ) do |result| 
			result.each { |row| 
				arr.push(row)
				}
		end
		arr
	end
	post '/hellopost' do
		params
	end
end

run MyAPI
