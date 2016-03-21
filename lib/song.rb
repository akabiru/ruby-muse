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

	def self.find_by_name name
		@@all.select { |song| song.name == name }.first
	end

	def self.find_or_create_by_name name
		result = find_by_name name
		result = create name unless result
		result
	end

end