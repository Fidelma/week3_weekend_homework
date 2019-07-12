require('pry')
require_relative('models/customer')
require_relative('models/film')

Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({
  'name' => 'Fi',
  'funds' => 20
  })

  customer1.save()

  film1 = Film.new({
    'title' => 'John Wick',
    'price' => 7
    })

  film1.save

  binding.pry
  nil
