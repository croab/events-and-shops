class Event < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :user
  has_many :event_bookings, dependent: :destroy
  has_many :attendees, through: :event_bookings, source: :user
  # Cloudinary
  has_one_attached :photo

  # VALIDATIONS
  # Validates presence of all
  validates :title, :description, :price, :location, :date, :time, presence: true

  # Validates title
  validates :title, length: { minimum: 5, maximum: 150 }

  # Validates description
  validates :description, length: { minimum: 40, maximum: 600 }

  # Validates price
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Validates location
  validates :location, length: { minimum: 2, maximum: 150 }

end
