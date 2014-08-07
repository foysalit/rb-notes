require 'digest/md5'

require_relative '../models/note'

module App::Factories
	class Note
		def initialize
			@model = App::Models::Note
		end

		def getAll
			return @model.all
		end

		def getOne id
			if id
				return @model.find(:id => id)
			else
				return nil
			end
		end

		def createOne data
			note = @model.new(title: data[:title], note: data[:note])
			note.save
		end

		def removeOne id
			@model.where(:id => id).destroy
		end

		def validateEntry? data
			return note
		end
	end
end