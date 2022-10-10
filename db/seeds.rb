puts "Deleting old records"
Shop.destroy_all
Event.destroy_all
User.destroy_all
Role.destroy_all
ShopAdmin.destroy_all
EventBooking.destroy_all
puts "Done"

# Creating users
puts "Creating users"
test_users = [
  {
    first_name: 'KING',
    last_name: 'KING',
    email: 'king@gmail.com',
    password: '123123',
  },
  {
    first_name: 'test_1',
    last_name: 'test_1',
    email: 'test_1@gmail.com',
    password: '123123',
  },
  {
    first_name: 'test_2',
    last_name: 'test_2',
    email: 'test_2@gmail.com',
    password: '123123',
  },
  {
    first_name: 'test_3',
    last_name: 'test_3',
    email: 'test_3@gmail.com',
    password: '123123',
  }
]

test_users.each do |user|
  new_user = User.new(
    first_name: user[:first_name],
    last_name: user[:last_name],
    email: user[:email],
    password: user[:password]
  )
  new_user.save!
end
puts "Done"

# Making KING admin
puts "Ensuring 'king@gmail.com' is admin"
User.first.role.update(admin: true)
puts "Done"

# Creating events


# Assigning attendees to events