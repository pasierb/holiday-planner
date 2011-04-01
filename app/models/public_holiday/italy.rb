class PublicHoliday::Italy < PublicHoliday

  #
  # list of polish public holidays 
  #
  def self.all( year = Time.now.year )
    [ PublicHoliday.new( :date => Date.civil( year,1,1 ), :code => :new_year ),
      PublicHoliday.new( :date => Date.civil( year,1,6 ), :code => :epiphany ),
      PublicHoliday.new( :date => self.easter( year), :code => :easter ),
      PublicHoliday.new( :date => self.easter( year ) + 1.day, :code => :easter_monday ),
      PublicHoliday.new( :date => Date.civil( year,4,25 ), :code => :anniversary_of_liberation ),
      PublicHoliday.new( :date => Date.civil( year,5,1), :code => :labour_day ),
      PublicHoliday.new( :date => Date.civil( year,6,2 ), :code => :republic_day ),
      PublicHoliday.new( :date => Date.civil( year,8,15 ), :code => :ferrogasto ),
      PublicHoliday.new( :date => Date.civil( year,11,1 ), :code => :all_saints ),
      PublicHoliday.new( :date => Date.civil( year,12,8 ), :code => :immaculate_conception ),
      PublicHoliday.new( :date => Date.civil( year,12,25 ), :code => :christmas ),
      PublicHoliday.new( :date => Date.civil( year,12,26 ), :code => :boxing_day )  ]
  end

end
