class Shop < ApplicationRecord
  has_many :shop_admins, dependent: :destroy
  has_many :admins, through: :shop_admin, source: :user

end
