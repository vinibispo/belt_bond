require "application_system_test_case"

class AuthTest < ApplicationSystemTestCase
  test "signs up to the website" do
    visit root_path

    click_on "Create your account"
    fill_in "What's your email?", with: "johndoe@beltbond.com"

    click_on "Create your account"

    assert_text "Please check your email and click the link we just sent."
  end
end
