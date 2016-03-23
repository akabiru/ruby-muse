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

	def self.create name, artist = nil, genre = nil
		Song.new(name, artist, genre).save
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

	def self.new_from_filename file_name
		names = file_name.split(" - ").collect { |name| name.gsub(/.mp3/, '') }

		artist = Artist.all.select { |a| a.name == names[0] }.first
		artist = Artist.new names[0] if artist.nil?
		genre = Genre.all.select { |g| g.name == names[2] }.first
		genre = Genre.new names[2] if genre.nil?

		Song.new(names[1], artist, genre)
	end

	def self.create_from_filename file_name
		names = file_name.split(" - ").collect { |name| name.gsub(/.mp3/, '') }

		artist = Artist.all.select { |a| a.name == names[0] }.first
		artist = Artist.create names[0] if artist.nil?
		genre = Genre.all.select { |g| g.name == names[2] }.first
		genre = Genre.create names[2] if genre.nil?

		Song.create(names[1], artist, genre)
	end

end