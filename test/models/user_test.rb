require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user save" do
    user = User.new({
      nickname: "NoYE",
      password: "abcd1234",
      description: "안녕하세요 삽질 장인입니다."
    })

    assert user.save, "Failed to save"
  end
end
