if Rails.env.development?
  Rails.application.configure do
    config.hosts << "dev.vinibispo.com"
  end
end
