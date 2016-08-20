class RentalDeserializer < DrivyDeserializer
  attribute :id, Integer
  attribute :car_id, Integer
  attribute :start_date, DateTime
  attribute :end_date, DateTime
  attribute :distance, Integer
  attribute :deductible_reduction, Boolean

  validates :id, :car_id, :start_date, :end_date, :distance, presence: true, allow_nil: false
  validates :distance, :car_id, numericality: { only_integer: true }

  def duration
    ( end_date - start_date.prev_day(1) ).to_i
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
end