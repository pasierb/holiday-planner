class LeaveRequestsController < ApplicationController

	layout "pdf"

  before_filter :get_localization

  def show
  	@since, @to, @total = params[:since], params[:to], params[:total]
  	@year = Time.new( ( @since || @to || Time.now.year ) ).year
  end

end
