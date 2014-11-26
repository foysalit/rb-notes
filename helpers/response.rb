require 'sinatra'
require "sinatra/json"

module App
	class Response
		include Sinatra::JSON
		def initialize response
			@res = response
			@res.headers['Content-type'] = "application/json"
			@res.headers['Access-Control-Allow-Origin']  = "*"
			@res.headers["Access-Control-Allow-Headers"] = "X-Requested-With"
			@res.headers['Access-Control-Allow-Methods'] = "GET, POST, PUT, DELETE, OPTIONS"
			@res.headers['Access-Control-Allow-Headers'] = "accept, authorization, origin"
		end

		def withError code = 500, message = "Server Error"
			@res.status = code
			{:error => true, :message => message}.to_json
		end

		def withData data, message=nil, code = 200
			@res.status = code
			ret = {:error => false, :data => data}

			if message != nil
				ret[:message] = message
			end

			ret.to_json
		end

		def noDataFound message = "Sorry the data cannot be found!"
			withData 404, message
		end

		def unauthorized message = "Sorry you don't have access!"
			withError 401, message
		end

		def actionError message = "Sorry we couldn't executed your requested action"
			withError 500, message
		end

		def dataFound data
			withData data
		end

		def dataCreated data, message = 'Your requested data has been stored successfully'
			withData data, message, 201
		end

		def dataDeleted message = 'Your requested data has been deleted'
			withData nil, message
		end
	end
end