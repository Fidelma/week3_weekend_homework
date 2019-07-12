require_relative('../db/sql_runner')

class Screening

  attr_accessor :film_id, :timing
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @timing = options['timing']
  end

  def save()
    sql = "INSERT INTO screenings
    (
      film_id,
      timing
      )
      VALUES ($1, $2)
      RETURNING id"
      values = [@film_id, @timing]
      @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def delete()
    sql = "DELETE FROM screenings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def tickets
    sql = "SELECT * FROM tickets
    WHERE tickets.screening_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |ticket| Ticket.new(ticket) }
  end


  def self.all()
    sql = "SELECT * FROM screenings"
    results = SqlRunner.run(sql)
    return results.map { |screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE screenings SET
    (
      film_id,
      timing
      )
      = ($1, $2)
      WHERE id = $3"
      values = [@film_id, @timing, @id]
      SqlRunner.run(sql, values)
  end


  end
