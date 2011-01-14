class PublicHoliday::Ireland < PublicHoliday

  def self.all( year = Time.now.year )
    PublicHoliday::England.all( year ) + [
      PublicHoliday.new( :date => Date.civil( year,3,17 ), :code => :st_patrick_day ),
      PublicHoliday.new( :date => Date.civil( year,7,12 ), :code => :orangemans_holiday )  ]
  end

end
