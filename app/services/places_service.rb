module PlacesService
  BASE_URL = 'https://search.reservamos.mx/api/v2/places'.freeze

  def self.get_places(query)
    connection = Faraday.new(BASE_URL) do |conn|
      conn.params['q'] = query
      conn.adapter Faraday.default_adapter
    end

    response = connection.get

    returns nil unless response.success?

    JSON.parse(response.body)
  end
end
