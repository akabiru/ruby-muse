class MusicLibraryController
	attr_accessor :path, :music_importer

	def initialize path = "./db/mp3s"
		@path = path
		@music_importer = MusicImporter.new @path
		@music_importer.import
	end

	def call
		print "-------- Ruby Muse --------\n"
		print "\n Commands\n"
		command_helper
		variable = ''
		while variable = gets.chomp do
			case variable
			when "list songs"
				@music_importer.files.each.with_index(1) { |v, i| puts i.to_s + ". " + v  }
			when "list artists"
				@music_importer.files.each { |a| puts a.split(" - ").first }
			when "list genres"
				@music_importer.files.each { |g| puts g.split(" - ")[2].gsub(/.mp3/, '') }
			when "play song"
				print "which number? "
				num = gets.chomp
				puts "Playing " + @music_importer.files[num.to_i - 1].gsub(/.mp3/, '')
			when "list artist"
				print "artist name: "
				name = gets.chomp
				@music_importer.files.each { |f| puts f if name == f.split(" - ").first }
			when "list genre"
				print "genre name: "
				name = gets.chomp
				@music_importer.files.each do |f|
					puts f if name == f.split(" - ")[2].gsub(/.mp3/, '')
				end
			when "help"
				command_helper
			when "exit"
				break
			else
				"Oops, your command is invalid."
			end
		end
	end

	def command_helper
		print "1.) list songs\n"
		print "2.) list artists\n"
		print "3.) list genre\n"
		print "4.) list artist\n\n"
	end
end