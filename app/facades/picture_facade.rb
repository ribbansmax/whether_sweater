class PictureFacade
  class << self
    def get_picture(location)
      picture = PexelsApiService.picture(location)
      picture = Image.new(picture, location)
    end
  end
end