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
end
