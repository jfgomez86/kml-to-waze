class Place < Sequel::Model
  attr_accessor :name, :coordinates, :waze_url, :google_maps_url, :xmlplacemark

  def before_create
    parse_attributes(@xmlplacemark)
  end

  def parse_attributes(xmlplacemark)
    self[:name]             = xmlplacemark.css("name").text
    self[:coordinates]      = xmlplacemark.css("coordinates").text.split(",")[0..1].reverse.join(",")
    self[:waze_url]         = "waze://?ll=#{self[:coordinates]}&navigate=yes"
    self[:google_maps_url]  = "comgooglemaps://?daddr=#{self[:coordinates]}&directionsmode=driving"
  end
end
