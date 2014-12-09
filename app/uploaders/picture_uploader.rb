# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  def create_marker

    # this is what we did to generate the alpha mask
    # $ convert marker.png -alpha extract marker_extract.png
    # the marker and alpha mask are in assets/images/marker
    # this is what we need to do in this process to compose the marker
    # $ composite -compose CopyOpacity marker_extract.png logo_image.png output.png

    # this is what we tried but the composite doesn't really work
    mask = MiniMagick::Image.new(Rails.root.join('app/assets/images/marker/marker_extract.png'))
    cache_stored_file! if !cached?
    tempfile = File.join(File.dirname(current_path), 'temp.png')
    #binding.pry
    puts(tempfile)
    source = MiniMagick::Image.new(current_path)

    result = source.composite(mask, 'png') do |c|
      c.compose "CopyOpacity"
    end

    #result.write tempfile

    result.write "public/#{store_dir}/marker.png"
    # or /\..{3,4}$/
    

    #binding.pry
    #real_current_path = current_path.sub /\.....?$/, '.png'

    #File.rename tempfile, real_current_path


  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [40, 40]
  end

  version :person_profile do
    process :resize_to_fill => [370, 370]
  end

  version :map_marker do
    process :convert => 'png'
    process :resize_to_fill => [40, 50]
    process :create_marker
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
