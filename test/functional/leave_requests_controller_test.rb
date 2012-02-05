require 'test_helper'

class LeaveRequestsControllerTest < ActionController::TestCase
  
  test "should get show" do
    get_leave_request
    assert_response :success
  end

  test "should store activity log" do
		assert_difference 'ActivityLog.count' do
  		get_leave_request
		end
	end
 
protected

	def get_leave_request
		get :show, :localization => "pl", :since => (Date.new + 3.days).to_s, :to => (Date.new + 10.days).to_s, :total => 4
	end

end
