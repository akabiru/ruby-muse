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
		add_song song
	end

	def add_song song 
		@songs.push song unless @songs.include? song
		song.genre = self unless song.genre
	end

	def artists
		artists_ = []
		@songs.each { |song| artists_.push song.artist unless artists_.include? song.artist }
		artists_
	end

end