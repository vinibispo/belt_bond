# Preview all emails at http://localhost:3000/rails/mailers/auth_mailer
class AuthMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/auth_mailer/login
  def login
    encrypted_email = Encryptor.encrypt("johndoe@beltbond.com", purpose: :login)
    AuthMailer.login(encrypted_email)
  end

end
