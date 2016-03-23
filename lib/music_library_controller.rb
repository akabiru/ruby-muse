class MusicLibraryController
	attr_accessor :path, :music_importer

	def initialize path = "./db/mp3s"
		@path = path
		@music_importer = MusicImporter.new @path
		@music_importer.import
	end

	def call
		MusicLibraryController.new
		print "Welcome to rubymuse!"
		variable = gets.chomp
		variable
	end
end