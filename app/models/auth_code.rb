class AuthCode < ApplicationRecord
  attr_keyring Rails.application.credentials.auth_code_encryption_key, digest_salt: Rails.application.credentials.auth_code_digest_salt

  attr_encrypt :code
  def initialize(*args)
    super(*args)
    self.code ||= Faker::Internet.username(specifier: 8..12, separators: ['-']) + SecureRandom.hex(4)
    self.expires_at ||= Time.now + 5.minutes
  end
end
