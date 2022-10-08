class User < ApplicationRecord
  after_create :create_user_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :role, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :event_bookings, dependent: :destroy
  has_many :shop_admins, dependent: :destroy

  # def is_site_admin?
  #   site_admin == true
  # end

  # def verify_site_admins
  #   puts "Test"
  #   # self.update(verified: true) if self.site_admin?
  #   self.verified = true if self.site_admin?
  # end

  def create_user_role
    role = Role.new(user: self)
    role.save!
  end
end
