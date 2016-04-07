class MusicLibraryController
  attr_accessor :path, :music_importer

  def initialize(path = './db/mp3s')
    @path = path
    @music_importer = MusicImporter.new(@path)
    @music_importer.import
  end

  def call
    puts propmt_title
    user_input = ''
    while user_input != 'exit'
      print '@~ '.colorize(:magenta)
      user_input = gets.chomp
      if cli_options.include? user_input
        send(cli_options[user_input])
      elsif user_input == 'help'
        puts command_helper
      else
        break if user_input == 'exit'
        puts invalid_command_helper
      end
    end
  end

  def propmt_title
    "
    ========================
          Ruby Muse
    ========================
    ".colorize(:cyan)
  end

  def cli_options
    {
      'list songs' => :list_songs,
      'list artists' => :list_artists,
      'list genres' => :list_genres,
      'play song' => :play_song,
      'list artist' => :list_artist,
      'list genre' => :list_genre
    }
  end

  def invalid_command_helper
    "
    Oops, invalid command.
    ".colorize(:red) +
      "
      Type 'help' for a list of available commands
      "
  end

  def list_songs
    Song.all.each.with_index(1) do |song, idx|
      puts "#{idx}. #{song}".colorize(:light_blue)
    end
  end

  def list_genres
    Song.all.uniq(&:genre).each do |song|
      puts song.genre.to_s.colorize(:light_blue)
    end
  end

  def list_artists
    Song.all.uniq(&:artist).each do |song|
      puts song.artist.to_s.colorize(:light_blue)
    end
  end

  def play_song
    print '  => which number? '.colorize(:yellow)
    num = gets.chomp
    song = Song.all[num.to_i - 1]
    if song
      puts " Playing #{song}"
    else
      puts "Song #{num} does not exist.".colorize(:red)
      puts "Enter number between 1..#{Song.all.size}.".colorize(:light_blue)
    end
  end

  def list_artist
    print '  => artist name: '.colorize(:yellow)
    name = gets.chomp
    artist = Artist.find_by_name(name)
    list_found(artist.songs, name)
  end

  def list_genre
    print '  => genre name: '.colorize(:yellow)
    name = gets.chomp
    genre = Genre.find_by_name(name)
    list_found(genre.songs, name)
  end

  def list_found(songs, name)
    if songs
      songs.each do |song|
        puts "#{song}".colorize(:blue)
      end
    else
      puts "#{name} not found.".colorize(:red)
    end
  end

  def command_helper
    " Commands:
    1.) list songs # lists all songs
    2.) list artists # lists all artists
    3.) list genres # lists all genres
    4.) list genre # lists a particular genre
    5.) list artist # lists a particular artist
    6.) play song # play a particular song

    exit # quit Ruby Muse
    ".colorize(:green)
  end
end
