class RestaurantFacade
  class << self
    def get_restaurant(location, food)
      restaurant = YelpApiService.restaurant(location)
      restaurant = Restaurant.new(restaurant)
    end
  end
end