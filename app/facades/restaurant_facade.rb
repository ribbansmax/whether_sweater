class RestaurantFacade
  class << self
    def get_restaurant(location, food)
      restaurant = YelpApiService.get_restaurant(location, food)
      Restaurant.new(restaurant)
    end
  end
end
