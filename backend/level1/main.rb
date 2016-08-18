require 'json'
require 'virtus'
require 'date'

class Drivy
  def initialize
    data = read_json('data.json')
    output_hash = {}
    output_hash['rentals'] = []

    cars = data['cars']
    rentals = data['rentals']
    
    rentals.each do |rental_json|
      rental_json['car'] = cars.select { |car| car['id'] == rental_json['car_id'] }.first
      rental = Rental.new(rental_json)
      output_hash['rentals'] << { id: rental.id, price: rental.amount }
    end

    generate_json(output_hash)
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
    self.end_date - self.start_date.prev_day(1)
  end

  def amount
    self.duration.to_i * self.car.price_per_day + self.distance * self.car.price_per_km
  end
end

Drivy.new