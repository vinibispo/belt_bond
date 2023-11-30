require 'active_support'
module Encryptor
  class << self

    def encrypt(unencrypted_message, expires_in: 10.minutes, purpose: nil)
      encryptor.encrypt_and_sign(unencrypted_message, expires_in:, purpose:)
    end

    def decrypt(encrypted_message, purpose: nil)
      encryptor.decrypt_and_verify(encrypted_message, purpose:)
    end

    private
    def encryptor
      ActiveSupport::MessageEncryptor.new(
        Base64.decode64(
          Rails.application.credentials.encryptor_secret
        )
      )
    end
  end
end
