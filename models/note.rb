require 'sequel'

require_relative 'initiate'

module App::Models
	class Note < Sequel::Model(:notes)
		plugin :json_serializer
		plugin :timestamps
	end
end