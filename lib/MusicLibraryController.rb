require 'pry'
class MusicLibraryController

  attr_accessor :list_songs

  def initialize(path = './db/mp3s')
    @path = path
    musicimporter_obj = MusicImporter.new(path)
    musicimporter_obj.import
  end

  def call
    input = " "
    while input != "exit"
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
    end
  end

  def list_songs
    listed_songs = Song.all.collect.sort_by{|song| song.name}
    listed_songs.uniq.each_with_index{|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    listed_artists = Artist.all.collect.sort_by{|artist| artist.name}
    listed_artists.each.with_index(1){|artist, index| puts "#{index}. #{artist.name}"}
  end

  def list_genres
    listed_genres = Genre.all.collect.sort_by{|genre| genre.name}
    listed_genres.each_with_index{|genre, index| puts "#{index+1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    if artist = Artist.find_by_name(input)
      songs_sorted_by_name = artist.songs.sort_by{|song|song.name}
      songs_sorted_by_name.each.with_index(1) do |song,index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    if genre = Genre.find_by_name(input)
      songs_sorted_by_name = genre.songs.sort_by{|song|song.name}
      songs_sorted_by_name.each.with_index(1) do |song,index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    list_songs = Song.all.sort{ |a, b| a.name <=> b.name }.uniq
    input = gets.strip.to_i

    if (1..Song.all.length).include?(input)
      song = list_songs[input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

end
