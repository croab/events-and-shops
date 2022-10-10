puts "Deleting old records"
Shop.destroy_all
Event.destroy_all
User.destroy_all
Role.destroy_all
ShopAdmin.destroy_all
EventBooking.destroy_all
puts "Old records destroyed"

test_users = [
  {
    first_name: ,
    last_name: ,
    email: ,
    password: ,

  }
]