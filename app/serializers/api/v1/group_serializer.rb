class Api::V1::GroupSerializer < ActiveModel::Serializer
  attributes :name,
             :address,
             :street,
             :zip,
             :city,
             :country,
             :time,
             :twitter,
             :level,
             :inactive,
             :allow_male_students,
             :students_count,
             :coaches_count

  def students_count
    object.students.size
  end

  def coaches_count
    object.coaches.size
  end
end