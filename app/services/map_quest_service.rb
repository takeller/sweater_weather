class MapQuestService
  include ServiceHelper

  def geocode(location)
    get_json("/geocoding/v1/address", {location: location})
  end

  def directions(end_location, start_location)
    get_json("/directions/v2/route", {from: start_location, to: end_location})
  end

  private

  def conn
    Faraday.new(url: "http://www.mapquestapi.com") do |faraday|
      faraday.params['key'] = ENV['MAPQUEST_KEY']
    end
  end
end
