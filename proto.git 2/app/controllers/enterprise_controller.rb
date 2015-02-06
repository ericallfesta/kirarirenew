class EnterpriseController < ApplicationController
  before_action :require_login
  before_action :check_role

  private

  def check_role
    raise 404 unless current_user.role == 'enterprise' && current_user.brand.present?
  end
end
