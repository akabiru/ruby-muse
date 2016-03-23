class MusicImporter
	attr_accessor :path
	attr_reader :files

	def initialize path
		@path = path
		@files = load_files path
	end

	def load_files path
		Dir.glob(path + "/*.mp3").collect { |f| File.basename f }
	end
end