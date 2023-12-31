class AuthMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.auth_mailer.login.subject
  #
  def login(encrypted_email, encrypted_login_link)
    email = Encryptor.decrypt(encrypted_email, purpose: :login)
    login_link = Encryptor.decrypt(encrypted_login_link, purpose: :login)

    return unless email

    mail(to: email, subject: "Login") do |format|
      format.html { render locals: { login_link: }}
    end
  end
end
