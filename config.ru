require 'grape'
require 'pg'
require 'json'
require 'bcrypt'
require 'securerandom'

class MyAPI < Grape::API
	
	version 'v1'

	format :json
	
	get '/hello' do
      		{ hello: 'world!' }
   	 end
    
	post '/hellopost' do
		params
	end

	get '/bs_metric' do
		conn = PG.connect(dbname: 'd3g1464c38fik7',
			host: 'ec2-54-235-134-167.compute-1.amazonaws.com',
			port: 5432,
			user: 'yyxehltyvhbqhh',
			password: 'K3qpFlhW38UUuc_kXWUBui9A2j'
		)
		arr = Array.new
		conn.exec("SELECT * FROM bs_metric") do |result|
			result.each{ |row|
				arr.push(row)
			}
		end
		arr
	end
	
	post '/login' do
		conn = PG.connect(dbname: 'd3g1464c38fik7',
			host:'ec2-54-235-134-167.compute-1.amazonaws.com',
			port:5432,
			user:'yyxehltyvhbqhh',
			password:'K3qpFlhW38UUuc_kXWUBui9A2j'
		)
		result = conn.exec("SELECT * FROM user_table WHERE username = '#{params.username}'");
		#result[0]['api_key']
		if result.ntuples && result[0]['hash'] == BCrypt::Engine.hash_secret(params.password, result[0]['salt'])
			{api_key: result[0]['api_key'], api_token: result[0]['api_token']}
		else
			{}
		end
	end
	
	post '/adduser' do
		conn = PG.connect(dbname: 'd3g1464c38fik7',
			host:'ec2-54-235-134-167.compute-1.amazonaws.com',
			port:5432,
			user:'yyxehltyvhbqhh',
			password:'K3qpFlhW38UUuc_kXWUBui9A2j'
		)
		mypassword = params.password
		mysalt = BCrypt::Engine.generate_salt
		encrypted_password = BCrypt::Engine.hash_secret(mypassword, mysalt)

		conn.exec("insert into user_table (user_id, username, first_name, hash, salt, api_key, api_token)values('#{params.user_id}', '#{params.username}', '#{params.firstname}', '#{encrypted_password}', '#{mysalt}', '123', '321')")
		
	end
	
	post '/bs_scoring' do
		conn = PG.connect(dbname: 'd3g1464c38fik7',
			host:'ec2-54-235-134-167.compute-1.amazonaws.com',
			port:5432,
			user:'yyxehltyvhbqhh',
			password:'K3qpFlhW38UUuc_kXWUBui9A2j'
		)
		keys_check = conn.exec("SELECT * FROM user_table WHERE user_id = '#{params.user_id}' AND api_token = '#{params.api_token}' AND api_key = '#{params.api_key}' ")
		if keys_check.ntuples
		
			rowcount = conn.exec("SELECT * FROM bs_scoring_lookup")
			#rowcount = rowcount+1;
			conn.exec("INSERT INTO bs_scoring_lookup values(#{rowcount.ntuples+1},'#{params.user_id}', '#{params.date_time}', '#{params.lp_id}','#{params.course_id}','#{params.user_id_accessor}')")
			
			
			map_data = JSON.parse(params.map_data)
			for i in 0..map_data.size-1
				conn.exec("INSERT INTO bs_score_map VALUES(#{rowcount.ntuples+1},'#{map_data[i]['bs_keyword_id']}', '#{map_data[i]['metric_id']}','#{map_data[i]['time_on_screen']}')")
			end
			conn.close()
			#map_data[0]
			
			#rowcount.ntuples
		else
			#invalid user/token/key
			{}
		end
	end
end

run MyAPI
