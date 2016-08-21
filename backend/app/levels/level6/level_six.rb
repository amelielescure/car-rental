class LevelSix
  def self.run
    data = JsonFileHelper.read_json('app/levels/level6/data.json')

    cars = data['cars']
    rentals = data['rentals']
    rental_modifications = data['rental_modifications']

    rental_modifications = rental_modifications.map do |rental_json|
      rental_modification = RentalModificationDeserializer.new(rental_json)

      rental = RentalDeserializer.new( rentals.select { |rental| rental['id'] == rental_json['rental_id'] }.first)
      car = CarDeserializer.new( cars.select { |car| car['id'] == rental.car_id }.first )

      if rental.valid? && car.valid? && rental_modification.valid?
        rental_price = RentalPrice.new(id: rental.id, rental: rental, car: car)

        rental_modification.rental_price = rental_price
        rental_modification.actions = rental_modification.actions_after_modification

        rental_modification.as_json(only: [:id, :rental_id, :actions])
      end
    end.compact

    output = {}
    output['rental_modifications'] = rental_modifications

    JsonFileHelper.generate_json(output, 'app/levels/level6/myoutput.json')
  end
end
