class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
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

  def self.create(name, artist = nil, genre = nil)
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

  def self.new_from_filename(file_name)
    names = file_name.sub(/.mp3/, '').split(' - ')
    Song.new(names[1],
             Artist.find_or_create_by_name(names[0]),
             Genre.find_or_create_by_name(names[2]))
  end

  def self.create_from_filename(file_name)
    names = file_name.sub(/.mp3/, '').split(' - ')
    Song.create(names[1],
                Artist.find_or_create_by_name(names[0]),
                Genre.find_or_create_by_name(names[2]))
  end

  def to_s
    "#{self.artist.name} - #{self.name} - #{self.genre.name}"
  end
end
