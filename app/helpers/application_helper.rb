module ApplicationHelper

  def flash_notice( options = {} )
    content_tag :div, { :class => "flash", :id => "flash-notice" }.merge( options ) do
      concat( flash[:notice] ).concat hide_button("flash-notice")
    end unless flash[:notice].blank?
  end

  def flash_error( options = {} )
    content_tag :div, { :class => "flash", :id => "flash-error" }.merge( options ) do
      concat( flash[:error] ).concat hide_button("flash-error")
    end unless flash[:error].blank?
  end

private

  def hide_button( id, options = {})
    content_tag :span, { :class => "flash-hide-button" }.merge( options ) do
      concat link_to_function("X","$('##{id}').hide()")
    end
  end

end
