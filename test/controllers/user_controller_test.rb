require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  @@token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiTm9ZRSIsImV4cCI6MTU4NTcyMzA3OX0.wjT4ZDZ8wd8-qQrkAo9cUB5jcl7dm2renJabLxdtymo"
  
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

  test "success signin" do
    post '/user/signin', params: { nickname: "NoYE", password: "duddms7181" }, as: :json

    assert_response 200
  end

  test "fail signin - not exist nickname" do
    post '/user/signin', params: { nickname: "NoYEaaa", password: "duddms7181" }, as: :json

    assert_response 405
  end

  test "fail signin - wrong password" do
    post '/user/signin', params: { nickname: "NoYE", password: "abcd234d" }, as: :json

    assert_response 405
  end

  test "success get profile" do
    get '/user/profile', headers: { "Access-Token" => @@token }

    assert_response 200
  end

  test "success put profile" do
    put '/user/profile', headers: { "Access-Token" => @@token }, params: { nickname: "NOOOOYE", description: "hello"}, as: :json
  
    assert_response 204
  end
end
