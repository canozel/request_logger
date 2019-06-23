module RequestLogger
  class Middleware

    ENV_KEYS = %w(
    REQUEST_METHOD HTTP_REFERER rack.input HTTP_USER_AGENT PATH_INFO QUERY_STRING
REQUEST_PATH REQUEST_URI HTTP_COOKIE AUTH_TYPE CONTENT_LENGTH CONTENT_TYPE GATEWAY_INTERFACE
HTTPS PATH_INFO PATH_TRANSLATED QUERY_STRING REMOTE_ADDR REMOTE_HOST REMOTE_IDENT REMOTE_USER
REQUEST_METHOD SCRIPT_NAME SERVER_NAME SERVER_PORT SERVER_PROTOCOL SERVER_SOFTWARE
)

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
