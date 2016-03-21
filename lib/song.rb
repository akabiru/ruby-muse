class Song
	attr_accessor :name
	attr_reader :artist, :genre
	@@all = []

	def initialize name, artist = nil, genre = nil
		@name = name
		self.artist = artist if artist
		self.genre = genre if genre
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
		Song.new(name).save
	end

	def artist=(artist_)
		@artist = artist_
		artist_.add_song self
	end

	def genre=(genre_)
		@genre = genre_
		genre_.add_song self
	end

end