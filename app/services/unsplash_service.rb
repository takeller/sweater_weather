class UnsplashService
  include ServiceHelper

  def image_search(search_params)
    get_json("/search/photos", {query: search_params})
  end

  private

  def conn
    Faraday.new(url: "https://api.unsplash.com") do |faraday|
      faraday.params['client_id'] = ENV['UNSPLASH_KEY']
    end
  end
end
