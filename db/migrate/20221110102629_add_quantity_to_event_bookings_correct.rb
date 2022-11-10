class AddQuantityToEventBookingsCorrect < ActiveRecord::Migration[7.0]
  def change
    add_column :event_bookings, :quantity, :integer
  end
end
