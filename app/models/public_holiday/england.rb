# January 1	New Year's Day
# variable	Good Friday
# Easter Monday
# 1st Monday in May	May Day Bank Holiday
# Last Monday in May	Spring Bank Holiday	(formally Whit Monday until 1971)
# Last Monday in August	Late Summer Bank Holiday
# December 25	Christmas Day
# December 26	Boxing Day

require 'chronic'

class PublicHoliday::England < PublicHoliday

  #
  # list of public holidays in England/Wales
  #
  def self.all( year = Time.now.year )
      context = Date.civil( year, 4, 4 )

    [ PublicHoliday.new( :date => Date.civil( year,1,1 ), :code => :new_year ),
      PublicHoliday.new( :date => self.easter( year) - 2.days, :code => :good_friday ),
      PublicHoliday.new( :date => self.easter( year ) + 1.day, :code => :easter_monday ),
      PublicHoliday.new( :date => Chronic.parse("1st Monday in may", :now => context).to_date, :code => :may_day ),
      PublicHoliday.new( :date => Chronic.parse("1st Monday in june", :now => context).to_date - 7.days, :code => :spring ),
      PublicHoliday.new( :date => Chronic.parse("1st Monday in September", :now => context).to_date - 7.days, :code => :late_summer ),
      PublicHoliday.new( :date => Date.civil( year,12,25 ), :code => :christmas ),
      PublicHoliday.new( :date => Date.civil( year,12,26 ), :code => :boxing_day )  ]
  end

end
