class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: :true
  validates :year, numericality: { only_integer: true, less_than: 2015, greater_than: 1041}

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

end
