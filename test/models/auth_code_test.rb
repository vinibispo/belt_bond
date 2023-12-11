require "test_helper"

class AuthCodeTest < ActiveSupport::TestCase
  test "detects expired code" do
    expires_at = 1.second.ago

    assert AuthCode.new(expires_at:).expired?
  end

  test "detects fresh code" do
    expires_at = 1.minute.from_now

    refute AuthCode.new(expires_at:).expired?
  end
end
