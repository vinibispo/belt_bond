class User < ApplicationRecord
  attr_keyring Rails.application.credentials.encryption_key, digest_salt: ""

  attr_encrypt :email
end
