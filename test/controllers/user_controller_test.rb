require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "success signup" do
    post '/user/signup', params: { nickname: "aanoye", password: "abcd1234" }, as: :json

    assert_response 201
  end

  test "fail signup - short password" do
    post '/user/signup', params: { nickname: "abnoye", password: "abcd"}, as: :json

    assert_response 405
  end

  test "fail signup - exists nickname" do
    post '/user/signup', params: { nickname: "NoYE", password: "abcd" }, as: :json

    assert_response 405
  end
end
