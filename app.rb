# temp_logger, a sinatra app to log temperatures to tempodb

require 'sinatra'
require 'tempodb'

disable :protection

get '/' do
  # setup the Tempo client
  api_key = ENV['TEMPODB_API_KEY']
  api_secret = ENV['TEMPODB_API_SECRET']
  api_host = ENV['TEMPODB_API_HOST']
  api_port = Integer(ENV['TEMPODB_API_PORT'])
  api_secure = ENV['TEMPODB_API_SECURE'] == "False" ? false : true

  client = TempoDB::Client.new( api_key, api_secret, api_host, api_port, api_secure )

  # try and get the most recent reading
  data = client.read_key('carter.temp', Time.now - 90, Time.now)
  last_temp = data.data.last.value
  last_temp_f = last_temp * 9.0 / 5.0 + 32.0

  "<div align=\"center\">It is %.2fF</div>" % last_temp_f
end

post '/temperature' do
  @temperature = params[:value]

  # setup the Tempo client
  api_key = ENV['TEMPODB_API_KEY']
  api_secret = ENV['TEMPODB_API_SECRET']
  api_host = ENV['TEMPODB_API_HOST']
  api_port = Integer(ENV['TEMPODB_API_PORT'])
  api_secure = ENV['TEMPODB_API_SECURE'] == "False" ? false : true

  client = TempoDB::Client.new( api_key, api_secret, api_host, api_port, api_secure )
  data = [ TempoDB::DataPoint.new( Time.now, @temperature.to_f ) ]
  client.write_key( "carter.temp", data )
end
