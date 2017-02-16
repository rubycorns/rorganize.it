module LocationFilter
  extend ActiveSupport::Concern

  included do
    scope :cities, -> { pluck(:city).uniq.compact.reject(&:blank?) }
    scope :by_city, -> (city) { where(city: city) }

    scope :countries, -> { pluck(:country).uniq.compact.reject(&:blank?) }
    scope :by_country, -> (country) { where(country: country) }

    def self.filtered_by_region(params)
      collection = all
      collection = collection.by_country(params[:country]) if params[:country].present?
      collection = collection.by_city(params[:city]) if params[:city].present?
      collection
    end
  end

  def country_name
    ISO3166::Country[country].name if country.present?
  end
end