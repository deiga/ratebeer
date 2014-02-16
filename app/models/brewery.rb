require 'date'

class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: :true
  validates :year, numericality: { only_integer: true, less_than_or_equal_to: ->(x) { Date.today.year }, greater_than_or_equal_to: 1042 }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
end
