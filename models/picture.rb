require 'sequel'

require_relative 'initiate'

module App::Models
	class Picture < Sequel::Model(:pictures)
		many_to_one :note
		plugin :json_serializer
		plugin :timestamps
	end
end