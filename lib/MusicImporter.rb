require 'pry'
class MusicImporter

  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files
    Dir.entries(@path).sort[2..6]
    end

  def import
    files.each do |filename|
      Song.create_from_filename(filename)
    end
  end

end
