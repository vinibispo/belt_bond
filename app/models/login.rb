class Login
  private attr_accessor :form

  def initialize(form)
    self.form = form
  end

  def call
    return [:error, 'Invalid email or password'] unless form.valid?

    login_link = Login::Link.create!(form.email)
    encrypted_email = Encryptor.encrypt(form.email, purpose: :login)
    encrypted_login_link = Encryptor.encrypt(login_link, purpose: :login)

    AuthMailer.login(encrypted_email, encrypted_login_link).deliver_later
    [:ok, 'Login successful']
  end
end
