#
# Polish public holidays (in polish :]):
#
# 1 stycznia - Nowy Rok
# 6 stycznia - Święto Trzech Króli - od 6 stycznia 2011 roku
# pierwszy dzień Wielkiej Nocy
# drugi dzień Wielkiej Nocy
# 1 maja - Święto Państwowe
# 3 maja - Święto Narodowe Trzeciego Maja
# pierwszy dzień Zielonych Świątek
# dzień Bożego Ciała
# 15 sierpnia - Wniebowzięcie Najświętszej Maryi Panny
# 1 listopada - Wszystkich Świętych
# 11 listopada - Narodowe Święto Niepodległości
# 25 grudnia - pierwszy dzień Bożego Narodzenia
# 26 grudnia - drugi dzień Bożego Narodzenia
#
class PublicHoliday::Poland < PublicHoliday

  #
  # list of polish public holidays 
  #
  def self.all( year = Time.now.year )
    [ PublicHoliday.new( :date => Date.civil( year,1,1 ), :code => :new_year ),
      PublicHoliday.new( :date => Date.civil( year,1,6 ), :code => :three_kings ),
      PublicHoliday.new( :date => self.easter( year), :code => :easter ),
      PublicHoliday.new( :date => self.easter( year ) + 1.day, :code => :easter_monday ),
      PublicHoliday.new( :date => self.easter( year)  + 48.days, :code => :pentecost ),
      PublicHoliday.new( :date => self.easter( year ) + 60.days, :code => :corpus_christi ),
      PublicHoliday.new( :date => Date.civil( year,5,1), :code => :first_of_may ),
      PublicHoliday.new( :date => Date.civil( year,5,3 ), :code => :third_of_may ),
      PublicHoliday.new( :date => Date.civil( year,8,15 ), :code => :maria ),
      PublicHoliday.new( :date => Date.civil( year,11,1 ), :code => :all_saints ),
      PublicHoliday.new( :date => Date.civil( year,11,11 ), :code => :independent ),
      PublicHoliday.new( :date => Date.civil( year,12,25 ), :code => :christmas ),
      PublicHoliday.new( :date => Date.civil( year,12,26 ), :code => :boxing_day )  ]
  end

end
