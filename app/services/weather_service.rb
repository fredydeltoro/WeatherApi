class WeatherService
  def initialize()
    @connection = Faraday.new('https://api.openweathermap.org/data/2.5/onecall') do |conn|
      conn.params['appid'] = OWMApiKey
      conn.params['units'] = 'metric'
      conn.adapter Faraday.default_adapter
    end
  end

  def get_temperature_by_cordinates(lat, lon)
    response = @connection.get do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['exclude'] = 'current,minutely,hourly'
    end

    returns nil unless response.success?

    JSON.parse(response.body)
  end
end