class CustomPagesController < ApplicationController
  #
  # Filters ---------------------------------------
  #
  before_filter :find_page

  def show
  end

protected

  def find_page
    @page = CustomPage.find_by_permalink_and_locale( params[:permalink], locale )
    unless @page
      flash[:error] = I18n.t('portal.page_not_found')
      redirect_to root_path 
    end
  end

end
