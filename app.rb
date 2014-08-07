require "rubygems"
require "sinatra"

require_relative 'helpers/response'
require_relative 'models/note'
require_relative 'factories/note'

before do
	@res = App::Response.new response
	@factory = App::Factories::Note.new
end

get '/notes' do
	@res.dataFound @factory.getAll
end

options '/notes/:id' do |id|
	@factory.removeOne id
	@res.dataDeleted
end

delete '/notes/:id' do |id|
	@factory.removeOne id
	@res.dataDeleted
end

get '/notes/:id' do |id|
	@res.dataFound @factory.getOne id
end

post '/notes' do
	note = @factory.createOne params
	@res.dataCreated note, "New Note Created"
end
