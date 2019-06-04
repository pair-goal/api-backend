require 'test_helper'

class GoalControllerTest < ActionDispatch::IntegrationTest
  @@token = JsonWebToken.encode({user_id: 1})

  test "success get goal" do
    get '/goal', headers: { "Access-Token" => @@token }

    assert_response 200
  end

  test "fail get goal - no token" do
    get '/goal'

    assert_response 403

  end

  test "success post goal" do
    post '/goal', 
      params: { title: "MyString", category_num: 1, start_date: "2019-03-23 14:20:33", end_date: "2019-03-23 14:20:33" },
      as: :json,
      headers: { "Access-Token" => @@token }

    assert_response 201
  end

  test "fail post goal - no token" do
    post '/goal',
      params: { title: "MyString", category: 1, startDate: "2019-03-23 14:20:33", endDate: "2019-03-23 14:20:33" },
      as: :json

    assert_response 403
  end

  test "success get goal details" do
    get '/goal/1', headers: { "Access-Token" => @@token }

    assert_response 200
  end

  test "fail get goal details - no token" do
    get '/goal/1'

    assert_response 403
  end

  test "success put goal details" do
    put '/goal/1',
      params: { title: "MyString", category: 1, startDate: "2019-03-23 14:20:33", endDate: "2019-03-23 14:20:33" },
      headers: { "Access-Token" => @@token }

    assert_response 204
  end

  test "fail put goal details - no token" do
    put '/goal/1',
      params: { title: "MyString", category: 1, startDate: "2019-03-23 14:20:33", endDate: "2019-03-23 14:20:33" }

    assert_response 403
  end

  test "success delete goal" do
    delete '/goal/1', headers: { "Access-Token" => @@token }

    assert_response 204
  end

  test "fail delete goal - no token" do
    delete '/goal/1'

    assert_response 403
  end
end
