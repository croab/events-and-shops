class Event < ApplicationRecord
  belongs_to :user
  has_many :event_bookings, dependent: :destroy

  has_many :attendees, through: :event_bookings, source: :user
  # has_many :event_bookings, dependent: :destroy
end
