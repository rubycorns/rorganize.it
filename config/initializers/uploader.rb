# Make sure every uploader inheriting from Base includes bombshelter
# protection
CarrierWave::Uploader::Base.class_eval do
  include CarrierWave::BombShelter
end
