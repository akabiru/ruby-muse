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

	def artist=(song_artist)
		@artist = song_artist
		song_artist.add_song(self)
	end

	def genre=(song_genre)
		@genre = song_genre
		song_genre.add_song(self)
	end

end