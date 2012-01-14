class PlannerController < ApplicationController

  before_filter :get_year
  before_filter :get_localization
  
  #
  # Main planner action, shows calendar planner
  #
  def show
    @public_holidays = get_public_holidays( @year )
    respond_to do |format|
      format.html
      format.xml
      format.json
    end
  end

protected

  #
  # returns year sent in request or current year
  #
  def get_year
    @year ||= params[:year] ? params[:year].to_i : Time.now.year
  end

  #
  # returns public holidays depending on current locale
  #
  def get_public_holidays( year )
    PublicHoliday.factory( @localization ).all( year )  
  end

end
