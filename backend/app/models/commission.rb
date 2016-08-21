class Commission < DrivyModel
  attribute :insurance_fee, Integer
  attribute :assistance_fee, Integer
  attribute :drivy_fee, Integer

  attribute :rental_price, RentalPrice

  def commission
    ( rental_price.discount_price * 0.3 ).to_i
  end

  def insurance_fee
    ( commission * 0.5 ).to_i
  end

  def assistance_fee
    ( rental_price.rental.duration * 100 ).to_i
  end

  def drivy_fee
    commission - ( insurance_fee + assistance_fee )
  end
end
