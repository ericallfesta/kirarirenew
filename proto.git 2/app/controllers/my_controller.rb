class MyController < ApplicationController
  before_action :require_login
  after_action :meta_nofollow
  after_action :meta_noindex
end
