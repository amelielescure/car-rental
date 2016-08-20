class RentalPrice < DrivyModel
  attribute :id, Integer
  attribute :price, Integer

  attribute :commission, Commission

  def as_json *args
  	hash = super
  	hash['commission'] = commission.as_json if hash['commission']
  	hash
  end
end