require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user save" do
    user = User.new({
      nickname: "NoYE",
      password: "abcd1234",
      description: "hello"
    })

    assert user.save, "Failed to save"
  end
end
