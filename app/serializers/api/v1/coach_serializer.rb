class Api::V1::CoachSerializer < ActiveModel::Serializer
  attributes(*Person.attribute_names.map(&:to_sym))
end