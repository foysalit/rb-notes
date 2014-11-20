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
	 		@model.all
		end

		def getAllWithPictures
			notes = @model.all
	 		pictures = @pictureModel.all

	 		notes.each do |note|
	 			note[:pictures] = Array.new

	 			pictures.each do |pic|
	 				if pic.note_id == note.id
	 					note[:pictures] << pic
	 				end
	 			end
	 		end

	 		return notes
		end

		def getOne id
			if id
				note = @model.find(:id => id)
				note[:pictures] = note.pictures
				return note
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

		def getMatched queryString
			query = "%#{queryString}%".strip
			note = @model.where("title LIKE :query OR note LIKE :query", :query => query, :query => query)
			return note
		end

		def createPicture note, pictureData
			picture = @pictureModel.new(data_uri: pictureData, note_id: note.id)
			picture.save
		end

		def removeOne id
			@pictureModel.where(:note_id => id).destroy
			@model.where(:id => id).destroy
		end

		def validateEntry? data
			return note
		end
	end
end