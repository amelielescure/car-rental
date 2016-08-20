class RentalDeserializer < DrivyDeserializer
  attribute :id, Integer
  attribute :car_id, Integer
  attribute :start_date, DateTime
  attribute :end_date, DateTime
  attribute :distance, Integer
  attribute :deductible_reduction, Boolean

  attribute :car, CarDeserializer

  validates :id, :car_id, :start_date, :end_date, :distance, presence: true, allow_nil: false
  validates :distance, :car_id, numericality: { only_integer: true }

  def duration
    end_date - start_date.prev_day(1)
  end

  def duration_with_reduction
    (0..(duration - 1)).map do |day|
      case day
      when 0    then 1
      when 1..3 then 0.9
      when 4..9 then 0.7
      else 0.5
      end
    end.inject(0, :+)
  end

  def price
    duration.to_i * car.price_per_day + distance * car.price_per_km 
  end

  def discount_price
    duration_with_reduction * car.price_per_day + distance * car.price_per_km
  end

  def commission
    ( discount_price * 0.3 ).to_i
  end

  def insurance_fee
    ( commission * 0.5 ).to_i
  end

  def assistance_fee
    duration * 100
  end

  def drivy_fee
    commission - ( insurance_fee + assistance_fee )
  end

  def deductible_reduction_price
    deductible_reduction ? duration * 400 : 0
  end
end