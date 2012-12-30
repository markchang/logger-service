# temp_logger, a sinatra app to log temperatures to tempodb

require 'sinatra'

disable :protection

get '/' do
  puts 'getting /'
  'It works!'
end

post '/temperature' do
  puts 'new temperature: '
  puts params[:target]
  puts params[:channel]
  puts params[:value]
end
