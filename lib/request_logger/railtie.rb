module RequestLogger
  class Railtie < Rails::Railtie
    initializer "request_logger.insert_middleware" do |app|
      app.config.middleware.insert_before 0, RequestLogger::Middleware
    end
  end
end
