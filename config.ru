require 'grape'
require 'pg'
require 'json'

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
	
	post '/bs_scoring' do
		conn = PG.connect(dbname: 'd3g1464c38fik7',
			host:'ec2-54-235-134-167.compute-1.amazonaws.com',
			port:5432,
			user:'yyxehltyvhbqhh',
			password:'K3qpFlhW38UUuc_kXWUBui9A2j'
		)
		conn.exec("INSERT INTO bs_scoring values('#{params.user_id}', '#{params.date_time}', '#{params.lp_id}','#{params.course_id}','#{params.bs_keyword_id}', '#{params.metric_id}','#{params.time_on_screen}','#{params.user_id_accessor}')")
		conn.close()
	end
end

run MyAPI
