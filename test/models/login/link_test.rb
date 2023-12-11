require 'test_helper'

class Login::LinkTest < ActiveSupport::TestCase
  setup do
    @email = "johndoe@beltbond.com"
  end
  test "creates a valid login url" do
    login_url = Login::Link.create!(
      @email
    )

    assert Login::Link.valid?(login_url)
  end

  test "rejects invalid urls" do
    login_url = Login::Link.create!(
      @email
    )

    AuthCode.last.update!(expires_at: 10.minutes.ago)

    refute Login::Link.valid?(login_url)
  end

  test "rejects code already used" do
    login_url = Login::Link.create!(
      @email
    )

    assert Login::Link.valid?(login_url)

    refute Login::Link.valid?(login_url)
  end

  test "rejects tempered urls" do
    login_url = Login::Link.create!(
      @email
    )
    login_url.gsub!(/email=([^&]+)/, "email=tempered")

    refute Login::Link.valid?(login_url)
  end
end
