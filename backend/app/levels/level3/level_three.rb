class LevelThree
  def initialize
    data = JsonFileHelper.read_json('app/levels/level3/data.json')

    cars = data['cars']
    rentals = data['rentals']
    
    rental_cars = rentals.map do |rental_json|
      rental = RentalDeserializer.new(rental_json)
      rental.car = CarDeserializer.new( data['cars'].select { |car| car['id'] == rental_json['car_id'] }.first )

      if rental.valid? && rental.car.valid?
        commission = Commission.new(
          insurance_fee: rental.insurance_fee ,
          assistance_fee: rental.assistance_fee ,
          drivy_fee: rental.drivy_fee
        )

        RentalPrice.new(
          id: rental.id,
          price: rental.discount_price, commission: commission
        ).as_json(only: [:id, :price, :commission])
      end
    end.compact

    output = {}
    output['rentals'] = rental_cars

    JsonFileHelper.generate_json(output, 'app/levels/level3/myoutput.json')
  end
end