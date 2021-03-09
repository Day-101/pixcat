class User < ApplicationRecord
  after_create :command_send
  after_create :create_cart

  def create_cart
    Cart.create(user: self)
  end

  def command_send
    UserMailer.command_email(self).deliver_now
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_one :cart
end
