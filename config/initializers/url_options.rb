if Rails.env.test? || Rails.env.production?
  Rails.application.routes.default_url_options = {
    host: "beltbond.com",
    protocol: "https"
  }
end
