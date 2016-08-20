class LevelTwo
  def initialize
    data = JsonFileHelper.read_json('app/levels/level2/data.json')

    cars = data['cars']
    rentals = data['rentals']
    
    rental_cars = rentals.map do |rental_json|
      rental_json['car'] = data['cars'].select { |car| car['id'] == rental_json['car_id'] }.first
      rental = RentalDeserializer.new(rental_json)
      RentalPrice.new(id: rental.id, price: rental.discount_price).as_json(only: [:id, :price]) if rental.valid?
    end.compact

    output = {}
    output['rentals'] = rental_cars

    JsonFileHelper.generate_json(output, 'app/levels/level2/myoutput.json')
  end
end