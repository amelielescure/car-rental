class DrivyModel
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON
  include Virtus.model

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    instance_values
  end
end
