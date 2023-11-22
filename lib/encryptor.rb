require 'active_support'
module Encryptor
  class << self

    def encrypt(unencrypted_message, expires_in: 10.minutes)
      encryptor.encrypt_and_sign(unencrypted_message, expires_in: expires_in)
    end

    def decrypt(encrypted_message)
      encryptor.decrypt_and_verify(encrypted_message)
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
