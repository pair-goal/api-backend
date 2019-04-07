require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user valid save" do
    user = User.new({
      nickname: "aanoYE",
      password: "abcd1234",
      description: "hello"
    })

    assert user.save, "Failed to save"
  end

  test "user invalid save" do
    long_nickname_user = User.new({
      nickname: "abcdefghijklmnopqrstuvwxyz",
      password: "abcd1234",
      description: "hello"
    })

    short_password_user = User.new({
      nickname: "nodYE",
      password: "aa",
      description: "hello"
    })

    long_password_user = User.new({
      nickname: "noYddE",
      password: "abcdefghijklmnopqrstuvwxyz",
      description: "hello"
    })

    assert !long_nickname_user.save, "Failed to long nickname validate"
    assert !short_password_user.save, "Failed to short password validate"
    assert !long_password_user.save, "Failed to long password validate"
  end

  test "find user test" do
    user = User.where(id: 1).first

    assert_instance_of User, user, "user is not instance of User"
    assert_equal users(:one).id, user.id
  end
end
