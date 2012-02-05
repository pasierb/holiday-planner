require 'test_helper'

class ActivityLogTest < ActiveSupport::TestCase

  test "create basic" do
    assert ActivityLog.create( :ip_address => "168.101.0.1", :note => "", :activity => "Something happend" )
  end

  test "create without ip" do
  	al = ActivityLog.new( :note => "", :activity => "Something happend" )
  	assert !al.save, al.errors.full_messages.to_s
	end

	test "create without activity" do
    al = ActivityLog.new( :ip_address => "168.101.0.1", :note => "" )
  	assert !al.save, al.errors.full_messages.to_s
	end

end
