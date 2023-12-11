if Rails.env.development?
  Rails.application.configure do
    config.action_mailer.smtp_settings = {
      port: 1025
    }
    config.action_mailer.perform_deliveries = true
  end
end
