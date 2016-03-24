class Artist
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
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

  def self.create(name)
    Artist.new(name).save
  end

  def songs=(song)
    add_song song
  end

  def add_song(song)
    @songs.push song unless @songs.include? song
    song.artist = self unless song.artist
  end

  def genres
    genres_ = []
    @songs.each do |song|
      genres_.push song.genre unless genres_.include? song.genre
    end
    genres_
  end
end
