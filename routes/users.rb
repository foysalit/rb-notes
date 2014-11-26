require_relative '../helpers/response'
require_relative '../models/user'
require_relative '../factories/user'

before do
	@res = App::Response.new response
	@factory = App::Factories::User.new
end

post '/user/me' do
	login = @factory.login params
	
	if (login.include?(:error))
		@res.unauthorized login[:error]
	else
		@res.dataFound login
	end
end

post '/user/signup' do
	signup = @factory.signup params
	
	if (signup.class == Hash && signup.include?(:error))
		@res.actionError signup[:error]
	else
		@res.dataCreated signup
	end
end

get '/user' do
	@res.dataFound ["test" => 'test']
end