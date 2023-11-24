module PlacesService
  BASE_URL = 'https://search.reservamos.mx/api/v2/places'.freeze

  def self.get_places(query)
    connection = Faraday.new(BASE_URL) do |conn|
      conn.params['q'] = query
      conn.adapter Faraday.default_adapter
    end

    response = connection.get

    return nil unless response.success?

    body = JSON.parse(response.body)

    # Array to collect results in parallel
    map_places = Concurrent::Array.new

    # Make requests in parallel
    promises = body.map do |place|
      Concurrent::Promise.execute do
        daily_temp = WeatherService.get_temperature_by_cordinates(place['lat'], place['long'])
        place['daily_temp'] = daily_temp
        map_places << place
      end
    end

    # Await for all promises are completed
    Concurrent::Promise.zip(*promises).wait

    map_places
  end
end
