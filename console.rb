require('pry')
require_relative('models/customer')

customer1 = Customer.new({
  'name' => 'Fi',
  'funds' => 20
  })

  binding.pry
  nil 
