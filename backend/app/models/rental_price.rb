class RentalPrice < DrivyModel
  attribute :id, Integer
  attribute :price, Integer

  attribute :options, Options
  attribute :commission, Commission

  def as_json *args
  	hash = super
  	hash['commission'] = commission.as_json if hash['commission']
  	hash['options'] = options.as_json if hash['options']
  	hash
  end
end