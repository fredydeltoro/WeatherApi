module WeatherService
  BASE_URL = 'https://api.openweathermap.org/data/2.5/onecall'.freeze

  def self.get_temperature_by_cordinates(lat, lon)
    connection = Faraday.new(BASE_URL) do |conn|
      conn.params['appid'] = OWMApiKey
      conn.params['units'] = 'metric'
      conn.adapter Faraday.default_adapter
    end

    response = connection.get do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['exclude'] = 'current,minutely,hourly'
    end

    returns nil unless response.success?

    JSON.parse(response.body)
  end
end
