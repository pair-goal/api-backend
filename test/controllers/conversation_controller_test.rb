require 'test_helper'

class ConversationControllerTest < ActionDispatch::IntegrationTest
  @@token = JsonWebToken.encode({user_id: 1})

  test "success get conversation" do
    get '/conversation', headers: { "Access-Token" => @@token }

    assert_response 200
  end

  test "fail get goal - no token" do
    get '/conversation'

    assert_response 403

  end

  test "success get conversation details" do
    get '/conversation/1', headers: { "Access-Token" => @@token }

    assert_response 200
  end

  test "fail get conversation details - no token" do
    get '/conversation/1'

    assert_response 403
  end

  test "success post conversation" do
    post '/conversation/1',
      params: { content: "chicken" }
      headers: { "Access-Token" => @@token }

    assert_response 204
  end

  test "fail post conversation - no token" do
    post '/conversation/1', params: { content: "chicken" }

    assert_response 204
  end
end
