class MusicLibraryController
  attr_accessor :path, :music_importer

  def initialize(path = './db/mp3s')
    @path = path
    @music_importer = MusicImporter.new @path
    @music_importer.import
  end

  def call
    print "|-------- Ruby Muse --------|\n"
    print "\n Commands\n"
    command_helper
    user_input = ''
    while user_input != "exit"
      print "@~ "
      user_input = gets.chomp
      case user_input
      when 'list songs'
        @music_importer.files.each.with_index(1) do |v, i|
          puts i.to_s + '. ' + v
        end
      when 'list artists'
        @music_importer.files.each { |a| puts a.split(' - ').first }
      when 'list genres'
        @music_importer.files.each do |g|
          puts g.split(' - ')[2].sub(/.mp3/, '')
        end
      when 'play song'
        print "  => which number? "
        num = gets.chomp
        puts 'Playing ' + @music_importer.files[num.to_i - 1].sub(/.mp3/, '')
      when 'list artist'
        print "  => artist name: "
        name = gets.chomp
        found =
          @music_importer.files.select { |f| name == f.split(' - ').first }
        if found.size > 0
          found.each { |f| puts f }
        else
          puts "#{name} not found."
        end
      when 'list genre'
        print "  => genre name: "
        name = gets.chomp
        found =
          @music_importer.files.select do |f|
            name == f.split(' - ')[2].sub(/.mp3/, '')
          end
        if found.size > 0
          found.each { |f| puts f }
        else
          puts "#{name} not found."
        end
      when 'help'
        command_helper
      else
        print "\nOops, your command is invalid. Try these:\n\n"
        command_helper
      end
    end
  end

  def command_helper
    print "1.) list songs # lists all songs\n"
    print "2.) list artists # lists all artists\n"
    print "3.) list genres # lists all genres\n"
    print "4.) list genre # lists a particular genre\n"
    print "5.) list artist # lists a particular artist\n"
    print "6.) play song # play a particular song\n\n"
  end
end
