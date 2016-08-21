class RentalModificationDeserializer < DrivyDeserializer
  attribute :id, Integer
  attribute :rental_id, Integer
  attribute :start_date, DateTime
  attribute :end_date, DateTime
  attribute :distance, Integer

  attribute :rental_price, RentalPrice
  attribute :actions, ActionsCollection[Actor]

  validates :id, :rental_id, presence: true, allow_nil: false
  validates :rental_id, numericality: { only_integer: true }

  def as_json *args
    hash = super
    hash['actions'] = actions.as_json if hash['actions']
    hash
  end

  def actions_after_modification
    actions_before_modifications = rental_price.actions

    rental_after = rental_price.rental
    rental_after.start_date = start_date unless start_date.nil?
    rental_after.end_date = end_date unless end_date.nil?
    rental_after.distance = distance unless distance.nil?
    rental_price_after = RentalPrice.new(id: rental_after.id, rental: rental_after, car: rental_price.car)

    actions_after_modifications = rental_price_after.actions

    new_actions = actions_after_modifications.zip(actions_before_modifications)
    new_actions = new_actions.map{ |actor|
      amount = actor.first.amount - actor.last.amount
      type = actor.first.type
      type = actor.first.type == "debit" ? "credit" : "debit" if amount < 0
      Actor.new(who: actor.first.who, type: type, amount: amount.abs)
    }
  end
end
