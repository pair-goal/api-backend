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
    get '/conversation/5cb3144b5773ef22dc0104de', headers: { "Access-Token" => @@token }

    assert_response 200
  end

  test "fail get conversation details - no token" do
    get '/conversation/5cb3144b5773ef22dc0104de'

    assert_response 403
  end

  test "success post conversation" do
    post '/conversation/5cb3144b5773ef22dc0104de',
      params: { content: "chicken" },
      headers: { "Access-Token" => @@token }

    assert_response 405
  end

  test "fail post conversation - no token" do
    post '/conversation/5cb3144b5773ef22dc0104de', params: { content: "chicken" }

    assert_response 403
  end
end
