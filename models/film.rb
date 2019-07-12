require_relative('../db/sql_runner')


class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
      )
      VALUES ($1, $2)
      RETURNING id"
      values = [@title, @price]
      @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM films"
    results = SqlRunner.run(sql)
    return results.map { |film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET
    (
      title,
      price
      )
      = ($1, $2)
      WHERE id = $3"
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
  end


end
