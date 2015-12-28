require 'rubygems'
require 'sinatra'

configure do
  enable :sessions
end

helpers do
end

get '/' do
  erb :index
end
