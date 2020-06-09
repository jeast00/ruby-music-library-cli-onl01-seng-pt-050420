


class MusicLibraryController

  def initialize(path = './db/mp3s')
    MusicImporter.new(path).import
  end

  def call

    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = gets
    until input == 'exit'
      if input == 'list songs'
        list_songs
      elsif input == 'list artists'
        list_artists
      elsif input == 'list genres'
        list_genres
      elsif input == 'list artist'
        list_songs_by_artist
      elsif input == 'list genre'
        list_songs_by_genre
      elsif input == 'play song'
        play_song
      elsif input == 'exit'
        exit
      else
        "There is no input for #{input}. Please refer to the top for selections."
        call
      end
    end

  end

  def list_songs
    # prints all songs in the music library in a numbered list (alphabetized by song name)
    # is not hard-coded - Need to use a sorting method and compare song A to song B and then loop with an index modifier with the artist, song, and genre in a puts statement.
    Song.all.sort { |song_a, song_b|
      song_a.name <=> song_b.name
    }.map.with_index { |song, index|
      puts "#{index+1}. " + song.artist.name + " - " + song.name + " - " + song.genre.name
    }
  end

  def list_artists
    # prints all artists in the music library in a numbered list (alphabetized by artist name)
    # is not hard-coded - Same as 'list_songs' method but just pass in artist
    Artist.all.sort { |artist_a, artist_b|
      artist_a.name <=> artist_b.name
    }.map.with_index { |artist, index|
      puts "#{index+1}. " + artist.name
    }
  end

  def list_genres
    Genre.all.sort { |genre_a, genre_b|
      genre_a.name <=> genre_b.name
    }.map.with_index { |genre, index|
      puts "#{index+1}. " + genre.name
    }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    if artist_name = Artist.find_by_name(input)
      artist_name.songs.sort { |artist_song_a, artist_song_b|
        artist_song_a.name <=> artist_song_b.name
      }.map.with_index { |artist_song, index|
        puts "#{index+1}. " + artist_song.name + " - " + artist_song.genre.name
      }
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets
    if genre_name = Genre.find_by_name(input)
      genre_name.songs.sort { |genre_song_a, genre_song_b|
        genre_song_a.name <=> genre_song_b.name
      }.map.with_index { |genre_song, index|
        puts "#{index+1}. " + genre_song.artist.name + " - " + genre_song.name
      }
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.to_i
    range = (1..Song.all.length)
    if Song.all.length.include?(input)
      played_song = Song.all.sort { |song_a, song_b|
        song_a.name <=> song_b.name
      }
    end
    if played_song
      puts "Playing " + played_song.name + " by " + played_song.artist.name
    end
  end

end
