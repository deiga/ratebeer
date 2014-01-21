class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    ratings.average('score')
    #ratings.inject(0) { |sum, elem| sum + elem.score }/ratings.count unless ratings.empty?
  end

  def to_s
    "#{name} - #{brewery.name}"
  end
end
