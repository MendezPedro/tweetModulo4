require 'test_helper'

class Api::V1::PostControllerTest < ActionDispatch::IntegrationTest
  test "should get news" do
    get api_v1_post_news_url
    assert_response :success
  end

end
