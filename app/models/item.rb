class Item < ApplicationRecord
  has_many :syndications
  has_many :feeds, through: :syndications
  has_many :reactions
end
