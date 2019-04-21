require 'test_helper'

class DiaryControllerTest < ActionDispatch::IntegrationTest
  @@token = JsonWebToken.encode({user_id: 1})
  @@today = Date.today.strftime("%Y%m%d")

  test "test success get diary" do
    get "/goal/1/diary/#{@@today}", headers: { "Access-Token" => @@token }

    assert_response 206
  end

  test "test fail get diary - no token" do
    get "/goal/1/diary/#{@@today}"

    assert_response 403
  end

  test "test success put diary" do
    put "/goal/1/diary/#{@@today}",
    params: { score: 0, comment: "yes!" },
    as: :json,
    headers: { "Access-Token" => @@token }

    assert_response 201
  end

  test "test fail put diary - no token" do
    put "/goal/1/diary/#{@@today}",
    params: { score: 0, comment: "yes!" }, as: :json

    assert_response 403
  end
end
