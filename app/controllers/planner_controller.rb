class PlannerController < ApplicationController
  
  #
  # Main planner action, shows calendar planner
  #
  def show
    @year = get_year
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
    params[:year] ? params[:year].to_i : Time.now.year
  end

  #
  # returns public holidays depending on current locale
  #
  def get_public_holidays( year )
    PublicHoliday.factory( set_localization ).all( year )  
  end

end
