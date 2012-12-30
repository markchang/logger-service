# temp_logger, a sinatra app to log temperatures to tempodb

require 'sinatra'

get '/' do
  'It works!'
end

post '/temperature' do
  puts params[:target]
  puts params[:channel]
  puts params[:value]
end
