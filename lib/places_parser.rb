require 'open-uri'
require 'nokogiri'

class PlacesParser

  attr_accessor :places

  def initialize(url, permalink)
    @permalink = permalink
    @document = open(url) { |io| Nokogiri::XML(io) }
    @places = []
    parse_places(@document, @permalink)
  end

  private

  def parse_places(xmldoc, permalink)
    @places = xmldoc.css("Placemark").inject(@places) do |places, placemark|
      places << parse_place(placemark, permalink)
    end
  end

  def parse_place(placemark, permalink)
    Place.create(xmlplacemark: placemark, permalink: permalink)
  end
end
