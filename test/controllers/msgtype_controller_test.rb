require 'test_helper'

class MsgtypeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get msgtype_new_url
    assert_response :success
  end

end
