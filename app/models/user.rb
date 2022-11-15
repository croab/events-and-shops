class User < ApplicationRecord
  after_create :create_user_role
  # Stripe
  after_save :assign_customer_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :role, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :event_bookings, dependent: :destroy
  has_many :shop_admins, dependent: :destroy

  # Validates presence of several
  validates :first_name, :last_name, :email, presence: true

  # Validates email
  validates :email, uniqueness: true

  def create_user_role
    role = Role.new(user: self)
    role.save!
  end

  # Stripe
  def assign_customer_id
    if self.customer_id.blank?
      customer = Stripe::Customer.create(email: email)
      self.update(customer_id: customer.id)
    end
  end

  # def products_purchased
  #   self.events.where.not(paid_at: nil)
  # end

  # def products_subscribed_on
  #   self.events.where.not(subscribed_at: nil)
  # end
end
