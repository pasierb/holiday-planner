xml.instruct!
xml.holiday_planner do
  xml.info do
    xml.localization "#{session[:localization]}"
    xml.language "#{I18n.locale}"
    xml.year @year
  end
  xml.public_holidays do
    @public_holidays.each do |p|
      xml.public_holiday do
        xml.code "#{ p.code }"
        xml.date p.date
        xml.name t( p.code )
      end
    end
  end
end
