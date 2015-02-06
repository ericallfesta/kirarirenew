class AdminController < ApplicationController
  layout 'admin/layouts/application'
  before_action :permit_admin
end
