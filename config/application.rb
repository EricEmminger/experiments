require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Experiments
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.debug_exception_response_format = :api
    config.action_controller.forgery_protection_origin_check = false
    config.session_store :cookie_store, domain: :all, tld_length: 2, key: '_experiments_session', httponly: false, secure: false, path: '/'
    config.active_job.queue_adapter = :resque
  end
end
