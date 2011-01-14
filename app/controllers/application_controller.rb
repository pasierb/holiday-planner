class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #
  # Filters
  #
  before_filter :set_locale
  before_filter :set_localization
  
protected

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    #session[:locale] = current_user.default_locale if current_user && current_user.default_locale.present?
    session[:locale] = I18n.locale unless session[:locale] 
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale]
  end

  def set_localization
    session[:localization] = cookies[:localization] = if params[:localization] != nil && params[:localization] != 'default'
      puts 1
      params[:localization]
    elsif session[:localization] 
      session[:localization]
    elsif cookies[:localization] 
      cookies[:localization]
    elsif params[:localization] == 'default'
      'pl'
    elsif current_user && current_user.default_location.present?
      current_user.default_location
    elsif !session[:localization] && !cookies[:localization] 
      'pl'
    end
    session[:localization] || cookies[:localization]
  end

end