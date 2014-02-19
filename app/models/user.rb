require 'securerandom'

class User < ActiveRecord::Base
  include RatingAverage, CollectionCache

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: {minimum: 4}, format: { with: /\A(?=.*\d)(?=.*[A-Z]).*\z/, message: 'requires at least one upper case letter and number' }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  scope :most_ratings, -> { order ratings_count: :desc }

  def to_s
    username
  end

  def favourite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favourite_style
    favourite :style
  end

  def favourite_brewery
    favourite :brewery
  end

  def favourite(category)
    return nil if ratings.empty?
    # get_favourite_group_by_rating_average(category)
    beers.group(category).average(:score).max_by { |ary| ary.last }.first
  end


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      if user.password_digest.blank?
        user.password = SecureRandom.hex(16).sub!(/\D/, &:capitalize)
        user.password_confirmation = user.password
      end
      user.oauth_token = auth.credentials.token
      user.new_record? ? user.save! : user.save!(validate: false)
    end
  end
end
