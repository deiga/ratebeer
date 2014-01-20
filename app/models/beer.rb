class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    ratings.average('score')
    #ratings.inject(0) { |sum, elem| sum + elem.score }/ratings.count unless ratings.empty?
  end
end
