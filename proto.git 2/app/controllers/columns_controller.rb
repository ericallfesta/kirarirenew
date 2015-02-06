class ColumnsController < ApplicationController
  def index
    @columns = Column.published.where( serial_id: params[:serial_id] ).page params[:page]
    @recently = Column.published.recently.includes(:writer).limit(3)
    @serials = Serial.opened.limit(3)
  end

  def show
    @column = Column.published.find params[:id]
  end

  def all
    @columns = Column.published.recently.includes(:writer).page params[:page]
    @page = params[:page]
  end
end
