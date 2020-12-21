require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get images_home_url
    assert_response :success
  end

end
