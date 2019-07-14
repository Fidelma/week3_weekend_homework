require_relative('../db/sql_runner')
require_relative('film')


class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
      )
      VALUES ($1, $2)
      RETURNING id"
      values = [@name, @funds]
      @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET
    (
      name,
      funds
    )
    = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN screenings
    ON screenings.film_id = films.id
    INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |film| Film.new(film) }
  end

  def self.all()
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
    return results.map { |customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def find_film(film)
    sql = "SELECT * FROM films
    WHERE title = $1"
    values = [film]
    results = SqlRunner.run(sql, values).first
    return Film.new(results)
  end

  def find_screening(film, screening)
    film = find_film(film)
    sql = "SELECT * FROM screenings
    WHERE film_id = $1 and timing = $2"
    values = [film.id, screening]
    result = SqlRunner.run(sql, values).first
    return Screening.new(result)
  end

  def buy_ticket(film, time)
    found_film = find_film(film)
    screening = find_screening(film, time)
    ticket = Ticket.new({
      'customer_id' => @id,
      'screening_id' => screening.id
      })
      ticket.save()
    @funds -= found_film.price
    update
  end

  def num_of_tickets
    sql = "SELECT * FROM tickets
    WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results_array = results.map { |ticket| Ticket.new(ticket)}
    return results_array.length
  end


end
