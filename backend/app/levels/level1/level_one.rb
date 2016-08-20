class LevelOne
  def initialize
    data = JsonFileHelper.read_json('app/levels/level1/data.json')

    cars = data['cars']
    rentals = data['rentals']
    
    rental_cars = rentals.map do |rental_json|
      rental_json['car'] = data['cars'].select { |car| car['id'] == rental_json['car_id'] }.first
      rental = RentalDeserializer.new(rental_json)
      RentalPrice.new(id: rental.id, price: rental.price) if rental.valid?
    end.compact

    output = {}
    output['rentals'] = rental_cars.as_json

    JsonFileHelper.generate_json(output, 'app/levels/level1/myoutput.json')
  end
end