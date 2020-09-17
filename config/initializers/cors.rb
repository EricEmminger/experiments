Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'spa.test'
    resource '*', headers: :any, methods: :any, credentials: true
  end
end
