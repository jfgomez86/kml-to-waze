class Place < Sequel::Model
  attr_accessor :name, :coordinates, :waze_url, :google_maps_url, :xmlplacemark

  def before_create
    parse_attributes(@xmlplacemark)
  end

  def parse_attributes(xmlplacemark)
    self[:name]             = xmlplacemark.css("name").text
    self[:coordinates]      = xmlplacemark.css("coordinates").text
    self[:waze_url]         = "waze://?ll=#{coordinates}&navigate=yes"
    self[:google_maps_url]  = "comgooglemaps://?daddr=#{coordinates}&directionsmode=driving"
  end
end

