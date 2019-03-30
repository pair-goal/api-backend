require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "success signup" do
    post :create, { nickname: "noye", password: "abcd1234" }

    assert_response 201
  end

  test "fail signup" do
    post :create, { nickanme: "noye", password: "abcd"}

    assert_response 405
  end

  test "success signin" do
    post :new, { nickname: "MyString", password: "MyString"}
    
    assert_response 200
  end

  test "fail signin" do
    post :new, { nickname: "MyString", password: "abcd1234"}

    assert_response 405
  end
end
