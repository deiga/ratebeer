class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}, format: { with: /(?=.*\d)(?=.*[A-Z])/, message: 'requires at least one upper case letter and number'}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    styles = {}
    ratings.chunk { |r| r.beer.style }.each { |x|  styles[x[0]] = x[1].inject(0) {|sum, rating| sum += rating.score }/x[1].count}
    styles.max_by { |x| x[1] }[0]
  end
end
