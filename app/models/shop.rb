class Shop < ApplicationRecord
  has_many :shop_admins
  has_many :admins, through: :shop_admin, source: :user

end
