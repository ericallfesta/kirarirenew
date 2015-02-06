class DefaultUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path "noimages/default.gif"
  end

  version :thumbnail do
    process resize_to_fill: [250, 250]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
