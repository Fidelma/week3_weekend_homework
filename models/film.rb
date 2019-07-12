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

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    INNER JOIN screenings
    ON tickets.screening_id = screenings.id
    WHERE screenings.film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |customer| Customer.new(customer) }
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

  def num_of_people
    sql = "SELECT tickets.* FROM tickets
    INNER JOIN screenings
    ON tickets.screening_id = screenings.id
    WHERE film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results_array = results.map { |ticket| Ticket.new(ticket)}
    return results_array.length
  end

  def screenings
    sql = "SELECT * FROM screenings
    WHERE film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |screening| Screening.new(screening) }
  end

  def tickets
    sql = "SELECT tickets.* FROM tickets
    INNER JOIN screenings
    ON tickets.screening_id = screenings.id
    WHERE screenings.film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |ticket| Ticket.new(ticket) }
  end

  def most_popular_time
    screenings
    ticket_sales = screenings.map { |screening| screening.num_of_tickets}
    sorted = ticket_sales.sort { |a,b| b <=> a }
    popular = sorted.first
    most_popular_time = screenings.find { |screening| screening.num_of_tickets == popular }
    return most_popular_time.timing
  end



end
