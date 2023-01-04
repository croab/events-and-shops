class Cart < ApplicationRecord
  has_many :event_bookings
  has_many :events, through: :event_bookings

  def total
    event_bookings.to_a.sum { |event_booking| event_booking.total}
  end

  def num_items
    event_bookings.to_a.sum { |event_booking| event_booking.quantity}
  end
end
