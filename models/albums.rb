require_relative '../db/sql_runner'

class Album

  attr_accessor :title, :genre
  attr_reader :id, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES($1, $2, $3)
    RETURNING id;"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, "save_album", values)[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums;"
    values = []
    albums = SqlRunner.run(sql, "list_all_albums", values)
    return albums.map { |album| Album.new(album)  }
  end

  def artist_of_album()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    results = SqlRunner.run(sql, "artist_of_album", values)
    artist = results[0]
    return Artist.new(artist)
  end


  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, "delete_one_album", values)
  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    values = []
    SqlRunner.run(sql, "delete_all_albums", values)
  end

  def update()
    sql = "
    UPDATE albums SET (title, genre, artist_id )
    =
    ($1, $2, $3)
    WHERE id = $4;"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql,"update_album", values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, "find_album", values)
    return result.map { |album| Album.new(album)  }
  end





end
