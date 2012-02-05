class LeaveRequestsController < ApplicationController

	layout "pdf"

  before_filter :get_localization
  before_filter :activity_log_show, :only => :show

  def show
  	@since, @to, @total = params[:since], params[:to], params[:total]
  	@year = Time.new( @since || @to || Time.now.year ).year
  end

protected

	def activity_log_show
		activity_log( :activity => "Leave request pdf", :note => params.inspect.to_s )
	end

end
