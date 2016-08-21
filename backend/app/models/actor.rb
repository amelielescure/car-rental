class Actor < DrivyModel
  attribute :who, String
  attribute :type, String
  attribute :amount, Integer

  def self.driver_amount rental_price
    rental_price.discount_price + rental_price.options.deductible_reduction
  end

  def self.owner_amount rental_price
    rental_price.discount_price - rental_price.commission.commission
  end

  def self.insurance_amount rental_price
    rental_price.commission.insurance_fee
  end

  def self.assistance_amount rental_price
    rental_price.commission.assistance_fee
  end

  def self.drivy_amount rental_price
    rental_price.commission.drivy_fee + rental_price.options.deductible_reduction
  end
end
