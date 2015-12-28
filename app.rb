$LOAD_PATH.unshift(File.expand_path("."))
require 'rubygems'
require 'config/db'
require 'lib/places_parser'
require 'lib/place'
require 'lib/permalink'
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
  @permalink = Permalink.create.permalink
  @places = PlacesParser.new(params["url"].gsub(/dl=0/, "dl=1"), @permalink).places
  redirect "/p/#{@permalink}"
end

get '/p/:permalink' do
  @permalink = params["permalink"]
  if Permalink.find(permalink: @permalink)
    @places = Place.where(permalink: @permalink)
    erb :places
  else
    404
  end
end
