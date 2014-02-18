require 'date'

class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: :true
  validates :year, numericality: { only_integer: true, less_than_or_equal_to: ->(x) { Date.today.year }, greater_than_or_equal_to: 1042 }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil,false] }

  def to_s
    name
  end

  def self.top(n)
   Brewery.all.sort_by{ |b| -(b.average_rating||0) }.take(n)
   # palauta listalta parhaat n kappaletta
   # miten? ks. http://www.ruby-doc.org/core-2.1.0/Array.html
 end

 def self.cache_key_collection
    max_updated_at = self.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{model_name.human.pluralize.downcase}/all-#{count}-#{max_updated_at}"
  end
end
