class Genre
	attr_accessor :name
	attr_reader :songs
	@@all = []

	def initialize name
		@name = name
		@songs = []
	end

	def self.all
		@@all
	end

	def self.destroy_all
		@@all = []
	end

	def save
		@@all.push self
		self
	end

	def self.create name
		Genre.new(name).save
	end

	def songs=(song)
		@songs.push song unless @songs.include? song
		song.genre = self unless song.genre
	end

	def add_song(song)
		self.songs = song
	end

end