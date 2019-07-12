require_relative('../db/sql_runner')

class Customer

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
      @id = SqlRunner.run(sql, values)
  end


end
