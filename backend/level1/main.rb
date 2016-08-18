require 'json'
require 'virtus'
require 'date'
require 'active_model'

class Drivy
  def initialize
    data = read_json('data.json')

    cars = data['cars']
    rentals = data['rentals']
    
    rental_cars = rentals.map do |rental_json|
      rental_json['car'] = data['cars'].select { |car| car['id'] == rental_json['car_id'] }.first
      rental = Rental.new(rental_json)
      RentalCar.new(id: rental.id, price: rental.amount)
    end

    output = {}
    output['rentals'] = rental_cars.as_json

    generate_json(output)
  end

  def read_json file
    file = File.read(file)
    JSON.parse(file)
  end

  def generate_json data
    File.open('myoutput.json', 'w') do |f|
      f.write( JSON.pretty_generate(data) )
    end
  end
end

class RentalCar
  include ActiveModel::Serializers::JSON
  include Virtus.model

  attribute :id, Integer
  attribute :price, Integer
end

class Car
  include Virtus.model

  attribute :id, Integer
  attribute :price_per_day, Integer
  attribute :price_per_km, Integer
end

class Rental
  include Virtus.model

  attribute :id, Integer
  attribute :car_id, Integer
  attribute :start_date, DateTime
  attribute :end_date, DateTime
  attribute :distance, Integer

  attribute :car, Car

  def duration
    end_date - start_date.prev_day(1)
  end

  def amount
    duration.to_i * car.price_per_day + distance * car.price_per_km
  end
end

Drivy.new