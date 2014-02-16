class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}, format: { with: /\A(?=.*\d)(?=.*[A-Z]).*\z/, message: 'requires at least one upper case letter and number'}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

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
    get_favourite_group_by_rating_average(category)
  end

  private
  def get_favourite_group_by_rating_average(category)
    group = ratings.group_by { |r| r.beer.send(category) }
    group.each { |k, ary|  group[k] = rating_average(ary) }.max_by { |label, score| score }.first
  end

  def sum_rating(ary)
    ary.inject(0.0) {|sum, rating| sum += rating.score }
  end

  def rating_average(ary)
    sum_rating(ary)/ary.count
  end
end
