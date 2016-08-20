class RentalPrice < DrivyModel
  attribute :id, Integer
  attribute :rental, RentalDeserializer
  attribute :car, CarDeserializer
  attribute :price, Integer

  attribute :options, Options
  attribute :commission, Commission

  def as_json *args
  	hash = super
  	hash['commission'] = commission.as_json(except: :rental_price) if hash['commission']
  	hash['options'] = options.as_json(except: :rental) if hash['options']
  	hash
  end

  def regular_price
    rental.duration.to_i * car.price_per_day + rental.distance * car.price_per_km 
  end

  def discount_price
    rental.duration_with_reduction * car.price_per_day + rental.distance * car.price_per_km
  end
end