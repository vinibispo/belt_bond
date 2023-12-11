module Login::Link
  class << self
    def create(email)
      auth_code = AuthCode.create!(
        code: Faker::Internet.username(specifier: 8..12, separators: ['-']) + SecureRandom.hex(4),
        expires_at: 5.minutes.from_now
      )

      url = Rails.application.routes.url_helpers.verify_email_url(
        email:,
        code: auth_code.code
      )

      SignedURL.call(url, key: Rails.application.credentials.signed_url_secret)
    end

    def valid?(signed_url)
      return unless SignedURL.verified?(signed_url, key: Rails.application.credentials.signed_url_secret)

      uri = URI.parse(signed_url)

      params = Rack::Utils.parse_query(uri.query)

      return unless params['code']

      auth_code = AuthCode.lock.find_by("expires_at > datetime('now') and code = :code", code: params['code'])

      return unless auth_code

      matched = ActiveSupport::SecurityUtils.secure_compare(auth_code.code, params['code'])

      auth_code.destroy!

      matched
    end
  end
end
