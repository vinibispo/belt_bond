require 'test_helper'

class EncryptorTest < ActiveSupport::TestCase
  test "encrypts message" do
    encrypted = Encryptor.encrypt("Hello world")
    refute_equal "Hello world", encrypted
  end

  test "decrypts message" do
    encrypted = Encryptor.encrypt("Hello world")
    decrypted = Encryptor.decrypt(encrypted)
    assert_equal "Hello world", decrypted
  end

  # test "raises error for invalid encrypted messages" do
  #   assert_raises (Encrypted::InvalidEncryptedMessage) do
  #     Encryptor.decrypt("bar")
  #   end
  # end
end
