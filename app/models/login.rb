class Login
  private attr_accessor :form

  def initialize(form)
    self.form = form
  end

  def call
    return [:error, 'Invalid email or password'] unless form.valid?

    link = Link.create(email: form.email)
    link.valid?(link)
    [:ok, 'Login successful']
  end
end
