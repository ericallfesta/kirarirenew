class Admin::ColumnsController < AdminController
  before_action :set_column, only: [:show, :edit, :update, :destroy]

  def index
    @columns = Column.where(serial_id: [nil, 0]).page params[:page]
  end

  def show
  end

  def new
    if params[:serial_id].present?
      serial = Serial.find params[:serial_id]
      @column = serial.columns.build
      @column.serial_num = serial.columns.count + 1
      @column.writer = serial.writer
    else
      @column = Column.new
    end
  end

  def edit
  end

  def create
    @column = Column.new(column_params)
    @column.serial = Serial.find params[:serial_id] if params[:serial_id].present?
    @column.serial_num = @column.serial.columns.count + 1 if @column.serial.present?

    if @column.save
      redirect_to admin_serials_url, notice: 'コラムを追加しました'
    else
      render action: 'new'
    end
  end

  def update
    if @column.update(column_params)
      redirect_to admin_serials_url, notice: 'コラムを編集しました'
    else
      render action: 'edit'
    end
  end

  def destroy
    @column.destroy
    redirect_to admin_serials_url, notice: 'コラムを削除しました'
  end

  private

  def set_column
    @column = Column.find(params[:id])
  end

  def column_params
    params.require(:column).permit :title, :substance, :writer_id, :body, :image, :remove_image, :image_cache, :status, :canonical_url, :published_at
  end
end
