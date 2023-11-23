module Login::Link
  class << self
    def create(email)
      auth_code = AuthCode.create!
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

      code_digest = AuthCode.keyring.digest(params['code'])

      auth_code = AuthCode
                  .lock
                  .where("expires_at > datetime('now')")
                  .find_by(code_digest: code_digest)

      return unless auth_code

      matched = ActiveSupport::SecurityUtils.secure_compare(auth_code.code, params['code'])

      auth_code.destroy!

      matched
    end
  end
end
