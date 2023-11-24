module WeatherService
  BASE_URL = 'https://api.openweathermap.org/data/2.5/onecall'.freeze
  CONNECTION = Faraday.new(BASE_URL) do |conn|
    conn.params['appid'] = OWMApiKey
    conn.params['units'] = 'metric'
    conn.params['exclude'] = 'current,minutely,hourly,alerts'
    conn.adapter Faraday.default_adapter
  end

  def self.get_temperature_by_cordinates(lat, lon)
    response = CONNECTION.get do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
    end

    returns nil unless response.success?

    body = JSON.parse(response.body)

    # Maping daily to get only the min and max temp
    daily = body["daily"].map do |day|
      # Convert epoch to date
      date = DateTime.strptime(day["dt"].to_s,'%s')
      date = date.to_date
      date = date.strftime

      {
        date: date,
        temp: { min: day["temp"]["min"], max: day["temp"]["max"] }
      }
    end

    daily
  end
end
