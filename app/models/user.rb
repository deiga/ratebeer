class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}, format: { with: /(?=.*\d)(?=.*[A-Z])/, message: 'requires at least one upper case letter and number'}

  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
end
