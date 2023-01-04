class Event < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :user
  has_many :event_bookings, dependent: :destroy
  has_many :carts, through: :event_bookings
  has_many :attendees, through: :event_bookings, source: :user
  # Cloudinary
  has_one_attached :photo

  # VALIDATIONS
  validates :title, :description, :price, :location, :date, :time, presence: true
  validates :title, length: { minimum: 5, maximum: 150 }
  validates :description, length: { minimum: 40, maximum: 600 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :location, length: { minimum: 2, maximum: 150 }

  # Algolia
  include AlgoliaSearch

  algoliasearch do
    # Use all default configuration
    # I can set up further configuration of Algolia here if needed
    # https://www.algolia.com/doc/framework-integration/rails/getting-started/setup/?client=ruby
  end

end
