require 'rubygems'
require 'sinatra'

configure do
  enable :sessions
end

helpers do
end

get '/' do
  erb :kml_form
end

post '/places' do
  print "parsing "
  puts params["url"].gsub(/dl=0/, "dl=1")
  @places = Places.new(params["url"].gsub(/dl=0/, "dl=1")).places
  erb :places
end

class Places
  require 'open-uri'
  require 'nokogiri'

  attr_accessor :places

  def initialize(url)
    @document = open(url) { |io| Nokogiri::XML(io) }
    @places = []
    parse_places(@document)
  end

  private

  def parse_places(xmldoc)
    @places = xmldoc.css("Placemark").inject(@places) do |places, placemark|
      places << parse_place(placemark)
    end
  end

  def parse_place(placemark)
    Place.new(placemark)
  end
end

class Place
  PUBLIC_ATTRIBUTES = [:name, :coordinates]
  attr_accessor *PUBLIC_ATTRIBUTES

  def initialize(xmlplacemark) # Nokogiri xml element
    parse_attributes(xmlplacemark)
  end

  def parse_attributes(xmlplacemark)
    PUBLIC_ATTRIBUTES.each do |attr|
      instance_variable_set("@#{attr.to_s}", xmlplacemark.css("name").text)
    end
  end

  def waze_url
    "waze://?ll=#{coordinates}&navigate=yes"
  end

  def google_maps_url
    "comgooglemaps://?daddr=#{coordinates}&directionsmode=driving"
  end
end
