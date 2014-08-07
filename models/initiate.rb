require 'rubygems'
require 'sequel'

Sequel::Model.plugin(:schema)
DB = Sequel.sqlite('database.db')

unless DB.table_exists? (:notes)
	DB.create_table :notes do
		primary_key :id
		string		:title
		text        :note
	end
end
