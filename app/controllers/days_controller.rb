class DaysController < ApplicationController
  before_filter :find_user
  
  def create
    @day = @user.days.new( params[:day] )
    if @day.save
      respond_to do |format|
        format.js { render :template => "days/create.js.erb" }
      end
    end
  end

  def destroy
    @day = @user.days.find_by_date( params[:id] )
    if @day && @day.destroy
      respond_to do |format|
        format.js { render :template => "days/destroy.js.erb" }
      end
    end
  end

  protected

  def find_user
    @user = User.find( params[:user_id] )
  end

end
