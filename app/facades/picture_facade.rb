class PictureFacade
  class << self
    def get_picture(location)
      picture = PexelsApiService.picture(location)
      Image.new(picture, location)
    end
  end
end
