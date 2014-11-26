require 'digest/md5'

require_relative '../models/note'
require_relative '../models/picture'

module App::Factories
	class Note
		def initialize
			@model = App::Models::Note
			@pictureModel = App::Models::Picture
		end

		def getAll
	 		notes = @model.eager(:pictures).all.map do |a|
				a.values.merge(:pictures=>a.pictures.map{|al| al.values})
			end

	 		return notes 
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

			if data[:pictures]
				data[:pictures].each do |i, picData|
					createPicture note, picData
				end
			end

			note
		end

		def createPicture note, pictureData
			picture = @pictureModel.new(data_uri: pictureData, note_id: note.id)
			picture.save
		end

		def removeOne id
			@model.where(:id => id).destroy
		end

		def validateEntry? data
			return note
		end
	end
end