#
# Base class for all country public holidays classes 
#
class PublicHoliday
  include ActiveModel::Serialization
  
  #
  # Attributes
  #
  attr_accessor :attributes, :date, :code

  def initialize( attributes = {} )
    @attributes = attributes
    self.date = attributes[:date]
    self.code = attributes[:code]
  end
  
  #
  # returns public day factory depending on locale
  #
  def self.factory( locale )
    eval self.config[locale.to_s]['klass']
  end

  def self.locations 
    PublicHoliday.config.reject{ |loc| loc == 'default'  }.collect{ |k,v| k = I18n.t('portal.localizations.full.'+k), v = k }
  end

  #
  # Christian-catolithic easter (sunday)
  # Meeusa/Jonesa/Butchera alghoritm found at wikipedia
  #
  def self.easter( year = Time.now.year ) 
    a = year % 19 #Dzielimy liczbę roku na 19 i wyznaczamy resztę a.
    b = year / 100 #Dzielimy liczbę roku przez 100, wynik zaokrąglamy w dół (odcinamy część ułamkową) i otrzymujemy liczbę b.
    c = year % 100 #Dzielimy liczbę roku przez 100 i otrzymujemy resztę c.
    d = b / 4 #Liczymy: b : 4 i wynik zaokrąglamy w dół i otrzymujemy liczbę d.
    e = b % 4 #Liczymy: b : 4 i wyznaczamy resztę e.
    f = (b+8) / 25 #Liczymy: (b + 8) : 25 i wynik zaokrąglamy w dół i otrzymujemy liczbę f.
    g = (b-f+1) / 3 #Liczymy: (b - f + 1) : 3 i wynik zaokrąglamy w dół i otrzymujemy liczbę g.
    h = ((19 * a)+b-d-g+15) % 30 #Liczymy: (19 x a + b - d - g + 15) : 30 i wyznaczamy resztę h.
    i = c / 4 #Liczymy: c : 4 i wynik zaokrąglamy w dół i otrzymujemy cyfrę i.
    k = c % 4 #Liczymy: c : 4 i wyznaczamy resztę k.
    l = (32 + (2*e) + (2*i) - h - k) % 7 #Liczymy: (32 + 2 x e + 2 x i - h - k) : 7 i otrzymujemy resztę l.
    m = (a + (11*h) + (22*l)) / 451 #Liczymy: (a + 11 x h + 22 x l) : 451 i wynik zaokrąglamy w dół i otrzymujemy liczbę m.
    p = (h + l - (7*m) + 114) % 31 #Liczymy: (h + l - 7 x m + 114) : 31 i otrzymujemy resztę p.
    day = p + 1#Dzień Wielkanocy = p + 1.
    month = (h + l - (7*m) + 114) / 31#Miesiąc = Zaokrąglenie w dół dzielenia (h + l - 7 x m + 114) przez 31.
    Date.civil(year,month,day)
  end


  #
  # parsed YAML config file
  #
  def self.config
    @config ||= YAML.load( self.config_file )
  end

protected

  #
  # default localization if not set by user
  #
  def self.default_localization
    self.config['default']
  end

private

  #
  # returns config file (/config/public_holidays.yml)
  #
  def self.config_file
    File.new("#{RAILS_ROOT}/config/public_holidays.yml")
  end

end
