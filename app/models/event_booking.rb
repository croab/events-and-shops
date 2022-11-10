class EventBooking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def total
    event.price * quantity
  end
end
