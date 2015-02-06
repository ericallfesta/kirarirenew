class Admin::MakersController < AdminController
  before_action :set_maker, only: [:show, :edit, :update, :destroy]

  def index
    @makers = Maker.page params[:page]
  end

  def show
  end

  def new
    @maker = Maker.new
  end

  def edit
  end

  def create
    @maker = Maker.new maker_params

    if @maker.save
      redirect_to admin_maker_path(@maker), notice: 'メーカーを追加しました'
    else
      render action: 'new'
    end
  end

  def update
    if @maker.update(maker_params)
      redirect_to admin_maker_path(@maker), notice: 'メーカーを編集しました'
    else
      logger.info @maker.errors.inspect
      render action: 'edit'
    end
  end

  private
    def set_maker
      @maker = Maker.find(params[:id])
    end

    def maker_params
      params.require(:maker).permit :name, :description, :website, :hero_image, :remove_hero_image
    end
end
