class Membership < ActiveRecord::Base
  validates :user, uniqueness: { scope: :beer_club, message: "can't join same club twice" }

  belongs_to :user
  belongs_to :beer_club
end
