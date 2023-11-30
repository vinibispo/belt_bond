class Email::Verify
  private attr_accessor :signed_url, :code, :email

  def initialize(signed_url:, code:, email:)
    self.signed_url = signed_url
    self.code = code
    self.email = email
  end

  def call
    return [:error, "Invalid url"] unless Login::Link.valid?(signed_url)

    user = User.find_or_create_by!(
      email_digest: User.keyring.digest(email)
    ) do |record|
      record.email = email
    end

    [:ok, user]

  end
end
