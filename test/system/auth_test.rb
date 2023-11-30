require "application_system_test_case"

class AuthTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  setup do
    Capybara.server_port = ActionMailer::Base.default_url_options[:port]
  end

  def click_email_link(label, mail = ActionMailer::Base.deliveries.last)
    html = Nokogiri::HTML(mail.body.to_s)
    link = html.css("a").find { |a| a.text == label }

    refute_nil link, "Couldn't find link with text #{label.inspect}"

    refute_nil link[:href], "Link with text #{label.inspect} has no href attribute"
    visit link[:href]
  end
  test "signs up to the website" do
    visit root_path

    click_on "Create your account"
    fill_in "What's your email?", with: "johndoe@beltbond.com"

    click_on "Create your account"

    assert_selector "p", text: "Please check your email and click the link we just sent."

    perform_enqueued_jobs

    click_email_link "Verify your email"

    assert_equal current_path, root_path

  assert_selector "span.username", text: User.last.username
  end
end
