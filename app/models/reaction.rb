class Reaction < ApplicationRecord
  belongs_to :profile
  belongs_to :item
end
