module Star
  extend ActiveSupport::Concern

  def star_symbols
    '★' * star.to_f.round + '☆' * (5 - star.to_f.round)
  end

  def star
    return nil if super.nil?
    super.to_f.round(1)
  end
end
