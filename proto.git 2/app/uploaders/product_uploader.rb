class ProductUploader < CarrierWave::Uploader::Base
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

  version :square do
    process pad_thumbnail: [500, 500, '#fff']
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  private

  def pad_thumbnail(width, height, background, gravity=::Magick::CenterGravity)
    manipulate! do |img|
      size = [img.columns, img.rows].max
      new_img = ::Magick::Image.new(size, size)
      filled = new_img.color_floodfill(1, 1, ::Magick::Pixel.from_color(background))
      destroy_image(new_img)
      filled.composite!(img, gravity, ::Magick::OverCompositeOp)
      destroy_image(img)
      filled = yield(filled) if block_given?
      filled.resize_to_fit!(width, height)
      filled
    end
  end
end
