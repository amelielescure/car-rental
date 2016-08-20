class LevelFour
	def initialize
    data = JsonFileHelper.read_json('app/levels/level4/data.json')

    cars = data['cars']
    rentals = data['rentals']
    
    rental_cars = rentals.map do |rental_json|
      rental = RentalDeserializer.new(rental_json)
      car = CarDeserializer.new( data['cars'].select { |car| car['id'] == rental_json['car_id'] }.first )

      if rental.valid? && car.valid?
        rental_price = RentalPrice.new(id: rental.id, rental: rental, car: car)
        rental_price.price = rental_price.discount_price

        options = Options.new(rental: rental)
        rental_price.options = options

        commission = Commission.new(rental_price: rental_price)
        rental_price.commission = commission
        
        rental_price.as_json(only: [:id, :price, :commission, :options])
      end
    end.compact

    output = {}
    output['rentals'] = rental_cars

    JsonFileHelper.generate_json(output, 'app/levels/level4/myoutput.json')
  end
end