class Admin::SerialsController < AdminController
  before_action :set_serial, only: [:show, :edit, :update, :destroy]

  def index
    @serials = Serial.page params[:page]
  end

  def show
  end

  def new
    @serial = Serial.new
  end

  def edit
  end

  def create
    @serial = Serial.new(serial_params)

    if @serial.save
      redirect_to admin_serials_url, notice: '連載を追加しました'
    else
      render action: 'new'
    end
  end

  def update
    if @serial.update(serial_params)
      redirect_to admin_serials_url, notice: '連載を編集しました'
    else
      render action: 'edit'
    end
  end

  def destroy
    @serial.destroy
    redirect_to admin_serials_url, notice: '連載を削除しました'
  end

  private

    def set_serial
      @serial = Serial.find(params[:id])
    end

    def serial_params
      params.require(:serial).permit(:title, :writer_id, :description, :status, :image, :remove_image, :image_cache, :published_at)
    end
end
