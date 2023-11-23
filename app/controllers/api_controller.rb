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
end
