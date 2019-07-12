require('pry')
require_relative('models/customer')

Customer.delete_all()


customer1 = Customer.new({
  'name' => 'Fi',
  'funds' => 20
  })

  # customer1.save()

  binding.pry
  nil
