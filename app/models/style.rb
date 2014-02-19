class Style < ActiveRecord::Base
  include RatingAverage, CollectionCache

  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    name
  end

  def self.top(n)
    Style.all.sort_by{ |b| -(b.average_rating||0) }.take(n)
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.1.0/Array.html
  end
end
