module SearchFilter
  extend ActiveSupport::Concern

  included do
    scope :cities, -> { pluck(:city).uniq.compact.reject(&:blank?) }
    scope :by_city, -> (city) { where(city: city) }

    scope :countries, -> { pluck(:country).uniq.compact.reject(&:blank?) }
    scope :by_country, -> (country) { where(country: country) }

    def self.filtered_by_params(params, signed_in = nil)
      collection = (signed_in || self.name != 'Person') ? all : all.public_profile
      case
      when params[:country].present?
        collection.by_country(params[:country])
      when params[:city].present?
        collection.by_city(params[:city])
      when params[:willing_to_travel] == '1'
        collection.willing_to_travel
      else
        collection
      end
    end

  end

  def country_name
    ISO3166::Country[country].name if country.present?
  end

end