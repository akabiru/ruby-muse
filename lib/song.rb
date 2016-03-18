class Song
	attr_accessor :name
	attr_reader :artist
	@@all = []

	def initialize name, artist = nil
		@name = name
		self.artist = artist if artist
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
end