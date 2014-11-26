require 'digest/md5'

require_relative '../models/user'

module App::Factories
	class User
		def initialize
			@model = App::Models::User
		end

		def login credentials
			validation = validate_credentials credentials
			
			if validation.class == Hash
				return validation
			elsif validation == true
				return credentials
			else
				return false
			end
		end

		def signup credentials
			validation = validate_credentials credentials

			if validation.class == Hash
				return validation
			end

			if user_exists(credentials[:username])
				return {:error => 'User already exists'}
			end

			user = @model.new(username: credentials[:username], password: credentials[:password])
			user.save
			
			return user
		end

		private
		def validate_credentials credentials
			if !(credentials.include?("username"))
				return {:error => 'Username must be set'}
			 elsif !(credentials.include?("password"))
				return {:error => 'Password must be set'}
			else
				return true
			end
		end

		def user_exists username
			return @model.find(:username => username)
		end
	end
end