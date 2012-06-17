#
# Austria public holidays:
#
# 1 January – New Year's Day
# 6 January – Epiphany
# Easter Monday*
# 1 May – Labor Day
# Ascension Day* – (Christi Himmelfahrt) 39 days after Easter Sunday
# Whit Sunday* – (Pfingsten) Pentecost Descent of the Holy Ghost upon the Apostles, 49 days after the Resurrection of Christ
# Corpus Christi* – First Holy Eucharist Last Supper. Thursday after Trinity Sunday (60 days after Easter Sunday)
# 15 August – Assumption of Mary
# 26 October – Austrian National Day (day of the Declaration of Neutrality)
# 1 November – All Saints' Day
# 8 December – Feast of the Immaculate Conception, retail stores are allowed to open for Christmas shopping
# 25 December – Christmas Day
# 26 December – St Stephen's Day

class PublicHoliday::Austria < PublicHoliday

  #
  # list of polish public holidays 
  #
  def self.all( year = Time.now.year )
    [ PublicHoliday.new( :date => Date.civil( year,1,1 ), :code => :new_year ),
      PublicHoliday.new( :date => Date.civil( year,1,6 ), :code => :three_kings ),
      PublicHoliday.new( :date => self.easter( year ) + 1.day, :code => :easter_monday ),
      PublicHoliday.new( :date => Date.civil( year,5,1), :code => :labour_day ),
      PublicHoliday.new( :date => self.easter( year ) + 39.day, :code => :feast_of_the_ascension ),
      PublicHoliday.new( :date => self.easter( year)  + 48.days, :code => :pentecost ),
      PublicHoliday.new( :date => self.easter( year ) + 60.days, :code => :corpus_christi ),
      PublicHoliday.new( :date => Date.civil( year,8,15 ), :code => :assumption_of_mary ),
      PublicHoliday.new( :date => Date.civil( year,10,26 ), :code => :austrian_national_day ),
      PublicHoliday.new( :date => Date.civil( year,11,1 ), :code => :all_saints ),
      PublicHoliday.new( :date => Date.civil( year,12,8 ), :code => :immaculate_conception ),
      PublicHoliday.new( :date => Date.civil( year,12,25 ), :code => :christmas ),
      PublicHoliday.new( :date => Date.civil( year,12,26 ), :code => :st_stephen )  ]
  end

end
