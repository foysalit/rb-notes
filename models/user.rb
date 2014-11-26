require 'sequel'

require_relative 'initiate'

module App::Models
	class User < Sequel::Model(:users)
		one_to_many :notes
		plugin :json_serializer
		plugin :timestamps
	end
end