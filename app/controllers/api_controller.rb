class ApiController < ApplicationController
  def check
    render json: {
      'ruby-version' => RUBY_VERSION,
      'rails-version' => Rails.version,
      'memory' => `ps -o rss= -p #{Process.pid}`.to_i / 1024, # Convert to megabytes
      'pid' => Process.pid,
      'uptime' => Time.now - Process.clock_gettime(Process::CLOCK_MONOTONIC),
      'environment' => Rails.env
    }    
  end

  def weather_by_place
    places = fetch_place_and_temp(params[:query])

    if places
      render json: places
    else
      render json: { error: 'Unable to get places and temperature at this moment.' }, status: :unprocessable_entity
    end
  end

  private

  def fetch_place_and_temp(query)
    PlacesService.get_places(query)
  end
end
