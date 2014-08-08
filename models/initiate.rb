require 'rubygems'
require 'sequel'
require 'logger'

Sequel::Model.plugin(:schema)
DB = Sequel.sqlite('database.db')

# Logger
log_file_path = "#{__FILE__}_#{Time.now.strftime("%Y%m%d")}.txt"
log_file = File.open(log_file_path, "a")
DB.loggers << Logger.new(log_file)

unless DB.table_exists? (:notes)
	DB.create_table :notes do
		primary_key :id
		string		:title
		text        :note
	end
end


unless DB.table_exists? (:pictures)
	DB.create_table :pictures do
		primary_key :id
		text		:data
		foreign_key :note_id, :notes
	end
end

if DB.table_exists? (:pictures)
	DB.alter_table(:pictures) do
		rename_column :data, :data_uri
	end
end