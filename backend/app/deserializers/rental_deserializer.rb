class RentalDeserializer
  include Virtus.model
  include ActiveModel::Model

  attribute :id, Integer
  attribute :car_id, Integer
  attribute :start_date, DateTime
  attribute :end_date, DateTime
  attribute :distance, Integer

  attribute :car, CarDeserializer

  validates :id, :car_id, :start_date, :end_date, :distance, presence: true, allow_nil: false

  def duration
    end_date - start_date.prev_day(1)
  end

  def amount
    duration.to_i * car.price_per_day + distance * car.price_per_km 
  end
end