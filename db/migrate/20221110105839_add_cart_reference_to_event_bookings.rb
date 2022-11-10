class AddCartReferenceToEventBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :event_bookings, :cart, foreign_key: true
  end
end
