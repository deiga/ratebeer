class Style < ActiveRecord::Base
  include RatingAverage

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

  def self.cache_key_collection
    max_updated_at = self.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{model_name.human.pluralize.downcase}/all-#{count}-#{max_updated_at}"
  end
end
