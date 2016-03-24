class MusicImporter
  attr_accessor :path
  attr_reader :files

  def initialize(path)
    @path = path
    @files = load_files
  end

  def load_files
    Dir.glob(File.join(@path, '*.mp3')).map { |f| File.basename(f) }
  end

  def import
    @files.each { |f| Song.create_from_filename f }
  end
end
