module RequestLogger
  class Middleware

    ENV_KEYS = %w(REQUEST_METHOD HTTP_REFERER rack.input)

    def initialize(app)
      @app = app
      @logger = Logger.new(Rails.root.join('log', "request.log"))
    end

    def call(env)
      @app.call(log(env))
    end

    private

    def log(env)
      @logger.info("-----REQUEST-----\n")
      ENV_KEYS.each do |key|
        next unless env[key]
        if key == 'rack.input'
          @logger.info("BODY: " + env[key].read + "\n")
          env[key].rewind
        else
          @logger.info("#{key}: " + env[key] + "\n")
        end
      end
      @logger.info("-----END-----\n")
      env
    end
  end
end
