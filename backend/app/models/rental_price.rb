class RentalPrice
  include ActiveModel::Serializers::JSON
  include Virtus.model

  attribute :id, Integer
  attribute :price, Integer
end