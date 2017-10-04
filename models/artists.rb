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

end
