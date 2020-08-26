module Api
  class ApiController < ApplicationController
    include Graphiti::Rails::Responders
    skip_before_action :verify_authenticity_token
  end
end