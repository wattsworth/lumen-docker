if ENV["SEND_EMAILS"].present?
  Rails.application.config.action_mailer.raise_delivery_errors = false
  Rails.application.config.action_mailer.delivery_method = :smtp
  Rails.application.config.action_mailer.smtp_settings = {
    address: ENV["SMTP_ADDRESS"],
    port: ENV["SMTP_PORT"],
    domain: ENV["SMTP_DOMAIN"],
    user_name: ENV["SMTP_USERNAME"],
    password: ENV["SMTP_PASSWORD"],
    authentication: ENV["SMTP_AUTHENTICATION"],
    enable_starttls_auto: ENV["SMTP_ENABLE_STARTTLS_AUTO"]
  }
end