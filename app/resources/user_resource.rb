# frozen_string_literal: true

# UserResource is only readable, Devise User is writable
class UserResource < ApplicationResource
  # self.attributes_readable_by_default = false # default true
  self.attributes_writable_by_default = false # default true
  self.attributes_filterable_by_default = false # default true
  self.attributes_sortable_by_default = false # default true
  # self.attributes_schema_by_default = false # default true

  has_many :profiles

  attribute :created_at, :datetime, writable: false
  attribute :current_sign_in_at, :datetime
  attribute :current_sign_in_ip, :string
  attribute :email, :string, only: [:readable]
  attribute :last_sign_in_at, :datetime
  attribute :last_sign_in_ip, :string
  attribute :updated_at, :datetime, writable: false

  def base_scope
    User.where(id: current_user)
  end
end
