class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def average_rating
    ratings.average('score')
    #ratings.inject(0) { |sum, elem| sum + elem.score }/ratings.count unless ratings.empty?
  end
end
