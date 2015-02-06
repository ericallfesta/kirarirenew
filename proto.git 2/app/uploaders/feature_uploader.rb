class FeatureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'http://placehold.jp/24/fafafa/fafafa/832x300.png'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumbnail do
    process resize_to_fill: [250, 250]
  end
end
