require 'sequel'

require_relative 'initiate'

module App::Models
	class Note < Sequel::Model(:notes)
		one_to_many :pictures
		plugin :json_serializer
		plugin :timestamps
	end
end