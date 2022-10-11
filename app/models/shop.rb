class Shop < ApplicationRecord
  has_many :shop_admins, dependent: :destroy
  has_many :admins, through: :shop_admin, source: :user

  # Presence of all
  validates :name, :summary, :description, presence: true
  # Name validations
  validates :name, length: { minimum: 2, maximum: 150 }
  # Summary validations
  validates :summary, length: { minimum: 2, maximum: 150 }
  # Description validations
  validates :description, length: { minimum: 40, maximum: 600 }
  # Shop url validations
  url_regex = /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})/
  validates :shop_url, format: { with: url_regex, message: "only allows valid urls" }
end
