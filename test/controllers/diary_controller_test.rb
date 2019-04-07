require 'test_helper'

class DiaryControllerTest < ActionDispatch::IntegrationTest
  @@token = JsonWebToken.encode({user_id: 1})

  test "test success get diary" do
    get '/diary/1', headers: { "Access-Token" => @@token }

    assert_response 200
  end

  test "test fail get diary - no token" do
    get '/diary/1'

    assert_response 403
  end

  test "test success put diary" do
    put '/diary/1', headers: { "Access-Token" => @@token }

    assert_response 204
  end

  test "test fail put diary - no token" do
    put '/diary/1'

    assert_response 403
  end
end
