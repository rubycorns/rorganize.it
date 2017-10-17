class Api::V1::CoachSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name

  has_many :groups, serializer: Api::V1::GroupSerializer
end