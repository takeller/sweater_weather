class HikingProjectService
  include ServiceHelper

  def trails(lat_long)
    get_json("/data/get-trails", {lat: lat_long['lat'], lon: lat_long['lng']})
  end

  private

  def conn
    Faraday.new(url: "https://www.hikingproject.com") do |faraday|
      faraday.params['key'] = ENV['HIKING_KEY']
    end
  end
end
