class CarDeserializer < DrivyDeserializer
  attribute :id, Integer
  attribute :price_per_day, Integer
  attribute :price_per_km, Integer

  validates :id, :price_per_day, :price_per_km, presence: true, allow_nil: false
end