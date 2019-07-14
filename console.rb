require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({
  'name' => 'Fi',
  'funds' => 20
  })

customer1.save()

customer2 = Customer.new({
  'name' => 'Bob',
  'funds' => 10
  })

customer2.save()

  film1 = Film.new({
    'title' => 'John Wick',
    'price' => 7
    })

  film1.save

  film2 = Film.new({
    'title' => 'Toy Story 4',
    'price' => 7
    })

  film2.save

  screening1 = Screening.new({
    'film_id' => film1.id,
    'timing' => '22:00'
    })

  screening1.save()

  screening2 = Screening.new({
    'film_id' => film1.id,
    'timing' => '20:00'
    })

  screening2.save()

  screening3 = Screening.new({
    'film_id' => film1.id,
    'timing' => '10:00'
    })

  screening3.save()

  screening4 = Screening.new({
    'film_id' => film2.id,
    'timing' => '10:00'
    })

  screening4.save()

  ticket1 = Ticket.new({
    'customer_id' => customer1.id,
    'screening_id' => screening1.id
    })

  # ticket1.save()

  ticket2 = Ticket.new({
    'customer_id' => customer1.id,
    'screening_id' => screening2.id
    })

  # ticket2.save()

  ticket3 = Ticket.new({
    'customer_id' => customer1.id,
    'screening_id' => screening1.id
    })

  # ticket3.save()

  ticket4 = Ticket.new({
    'customer_id' => customer2.id,
    'screening_id' => screening2.id
    })

  # ticket4.save()

  ticket5 = Ticket.new({
    'customer_id' => customer1.id,
    'screening_id' => screening2.id
    })

  # ticket5.save()


  binding.pry
  nil
