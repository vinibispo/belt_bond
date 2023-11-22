module Login::Link
  class << self
    def create(email)
      
      SignedURL.call(
        url,
        key: Rails.application.credentials.url_signature_secret,
        expires: 2.minutes.from_now,
      )
    end

    def valid?(link)
    end
  end
end
