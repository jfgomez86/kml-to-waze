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
  erb :places
end
