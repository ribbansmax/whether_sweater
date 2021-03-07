class Image
  attr_reader :id, :location, :image_url, :credit

  def initialize(data, location)
    image = data[:photos].first
    @id = nil
    @location = location
    @image_url = image[:url]
    @credit = {
      source: 'https://www.pexels.com',
      author: image[:photographer],
      author_page: image[:photographer_url]
    }
  end
end