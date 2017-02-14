module LocationFilter
  extend ActiveSupport::Concern

  included do
    scope :cities, -> { pluck(:city).uniq.compact.reject(&:blank?) }
    scope :by_city, -> (city) { where(city: city) }

    scope :countries, -> { pluck(:country).uniq.compact.reject(&:blank?) }
    scope :by_country, -> (country) { where(country: country) }

    def self.filtered_by_region(params, signed_in = nil)
      collection = (signed_in || !self.respond_to?(:public_profile)) ? all : all.public_profile
      if params[:country] && params[:city]
        collection.by_country(params[:country]).by_city(params[:city])
      elsif params[:country]
        collection.by_country(params[:country])
      elsif params[:city]
        collection.by_city(params[:city])
      else
        collection
      end
    end
  end

  def country_name
    ISO3166::Country[country].name if country.present?
  end
end