class SerialsController < ApplicationController
  def index
    @serials = Serial.opened.page params[:page]
  end

  def show
    @serial = Serial.opened.find(params[:id])
  end
end
