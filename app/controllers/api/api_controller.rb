# frozen_string_literal: true

module Api
  # ApiController
  class ApiController < ApplicationController
    before_action :authenticate_user!
    include Graphiti::Rails::Responders
    protect_from_forgery unless: -> { request.format.json? || request.format.jsonapi? }
  end
end
