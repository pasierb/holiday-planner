class Admin::BaseController < ApplicationController
  layout 'admin'


#
# Filters -----------------------------------------
#
before_filter :authenticate_user!
before_filter :admin_required

#
# Inherited resources -----------------------------
#
inherit_resources
defaults :route_prefix => 'admin'


protected 

  def admin_required
    unless current_user.is_admin?
      flash[:error] = I18n.t('portal.access_denied')
      redirect_to root_path
    end
  end

end
