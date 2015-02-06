module Favorable
  extend ActiveSupport::Concern

  def is_faved? user
    Favorite.where(user: user, favorable: self).count > 0
  end
end
