class Rating < ActiveRecord::Base
  include CollectionCache
  belongs_to :beer, touch: true
  belongs_to :user, counter_cache: true, touch: true

  validates :score, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 50, only_integer: true }

  scope :recent, ->() { order created_at: :desc }

  def to_s
    "#{beer.name} #{score}"
  end
end
