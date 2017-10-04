require_relative '../db/sql_runner'

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id;"
    values = [@name]
    result = SqlRunner.run(sql, "save_artist", values)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM artists;"
    values = []
    artists = SqlRunner.run(sql, "list_all_artists", values)
    return artists.map { |artist| Artist.new(artist) }
  end


  def albums_by_artist()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [id]
    albums = SqlRunner.run(sql, "albums_by_artist", values)
    result = albums.map { |album| Album.new(album)  }
    return result
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, "delete_one_artist", values)
  end

  def self.delete_all()
    sql = "DELETE FROM artists;"
    values = []
    SqlRunner.run(sql, "delete_all_artists", values)
  end

  def update()
    sql = "UPDATE artists SET (name) = ($1) WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql,"update_artist", values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, "find_artist", values)
    return result.map { |artist| Artist.new(artist)  }
  end


end
