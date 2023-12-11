if Rails.env.development? || Rails.env.production?
  Rails.application.routes.default_url_options = {
    host: "dev.vinibispo.com",
    protocol: "https"
  }

  Rails.application.config.action_mailer.default_url_options = Rails.application.routes.default_url_options
end

if Rails.env.test?
  Rails.application.routes.default_url_options = {
    host: "localhost",
    protocol: "http",
    port: 12_121
  }

  Rails.application.config.action_mailer.default_url_options = Rails.application.routes.default_url_options
end
