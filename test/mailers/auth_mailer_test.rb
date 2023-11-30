require "test_helper"

class AuthMailerTest < ActionMailer::TestCase
  test "login" do
    email = "johndoe@beltbond.com"
    encrypted_email = Encryptor.encrypt(email, purpose: :login)
    encrypted_login_link = Encryptor.encrypt("https://example.com", purpose: :login)

    mail = AuthMailer.login(encrypted_email, encrypted_login_link)
    assert_equal "Login", mail.subject
    assert_equal ["johndoe@beltbond.com"], mail.to
    assert_equal ["hi@beltbond.com"], mail.from
    assert_match "example.com", mail.body
  end

end
