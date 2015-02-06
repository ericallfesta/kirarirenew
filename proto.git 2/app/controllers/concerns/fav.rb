module Fav
  extend ActiveSupport::Concern

  included do
    before_action :set_fav_target, only: [:fav]
  end

  def fav
    respond_to do |format|
      format.json {
        if current_user.favorited? @fav_target
          res = { result: current_user.unfav(@fav_target).present?, action: 'unfav' }
        else
          res = { result: current_user.fav(@fav_target).present?, action: 'fav' }
        end
        res.merge!({id: @fav_target.id}) if res[:result]
        res.merge!({target: @fav_target.class.to_s.downcase.pluralize}) if res[:result]
        render json: res.to_json
      }
    end
  end
end
