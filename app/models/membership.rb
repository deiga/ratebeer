class Membership < ActiveRecord::Base
  validates :user, uniqueness: { scope: :beer_club, message: "can't join same club twice" }
  after_initialize :init

  belongs_to :user
  belongs_to :beer_club

  scope :confirmed, -> { where confirmed: true }
  scope :unconfirmed, -> { where confirmed: false | nil }

  private

    def init
      self.confirmed ||= false
    end
end
