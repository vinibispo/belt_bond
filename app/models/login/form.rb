class Login::Form
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :email

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
