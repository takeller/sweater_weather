class BackgroundResults

  def initialize
    @unsplash_service ||= UnsplashService.new
  end

  def background_image(location)
    image_response = @unsplash_service.image_search(location)
    image_response[:results][0][:links][:html]
  end
end
