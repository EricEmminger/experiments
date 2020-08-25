class ReactionResource < ApplicationResource
  belongs_to :profile
  belongs_to :item

  attribute :profile_id, :integer
  attribute :item_id, :integer
  attribute :kind, :string
end
