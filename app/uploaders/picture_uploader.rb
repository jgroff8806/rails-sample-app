class PictureUploader < CarrierWave::Uploader::Base
  # Utilizes CarrierWave gem for picture uploading
  # Resizes a picture upon upload if it's larger than 400x400 to keep the micropost feed uniform
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]
  # Checks to see if Rails environment is in production or development mode
  if Rails.env.production?
    # Rails will use the fog gem for cloud file uploading if in production mode
    storage :fog
  else
    # Rails will use local storage for file uploading if in development mode
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end