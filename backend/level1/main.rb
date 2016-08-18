require 'virtus'
require 'active_model'
require 'json'
require 'require_all'
require_all '../app'

require 'pry'

class Drivy
  def initialize
    data = JsonFileHelper.read_json('data.json')

    cars = data['cars']
    rentals = data['rentals']
    
    rental_cars = rentals.map do |rental_json|
      rental_json['car'] = data['cars'].select { |car| car['id'] == rental_json['car_id'] }.first
      rental = RentalDeserializer.new(rental_json)
      RentalCar.new(id: rental.id, price: rental.amount) if rental.valid?
    end.compact

    output = {}
    output['rentals'] = rental_cars.as_json

    JsonFileHelper.generate_json(output)
  end
end

Drivy.new