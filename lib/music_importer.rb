class MusicImporter
	attr_accessor :path
	attr_reader :files

	def initialize path
		@path = path
		@files = load_files path
	end

	def load_files path
		files_ = []
		Dir.glob(path + "/*.mp3").each { |f| files_.push File.basename f }
		files_
	end
end