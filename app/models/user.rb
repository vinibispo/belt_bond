class User < ApplicationRecord
  attr_keyring Rails.application.credentials.encryption_key, digest_salt: ""

  attr_encrypt :email

  def initialize(*args)
    super(*args)

    self.username = Faker::Internet.username
  end
end
