class Options < DrivyModel
  attribute :deductible_reduction, Integer

  attribute :rental, RentalDeserializer

  def deductible_reduction
    rental.deductible_reduction ? rental.duration * 400 : 0
  end
end
