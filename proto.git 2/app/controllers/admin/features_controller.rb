class Admin::FeaturesController < AdminController
  before_action :set_feature, only: [:show, :edit, :update, :destroy]

  def index
    @features = Feature.page params[:page]
  end

  def show
  end

  def new
    @feature = Feature.new
  end

  def edit
  end

  def create
    @feature = Feature.new(feature_params)

    if @feature.save
      redirect_to [:admin, @feature], notice: '特集を追加しました'
    else
      render action: 'new'
    end
  end

  def update
    if @feature.update(feature_params)
      redirect_to [:admin, @feature], notice: '特集を編集しました'
    else
      render action: 'edit'
    end
  end

  def destroy
    @feature.destroy
    redirect_to admin_features_url
  end

  private
    def set_feature
      @feature = Feature.find(params[:id])
    end

    def feature_params
      params.require(:feature).permit(:title, :description, :hero_image, :remove_hero_image, :hero_image_cache, :sidebar_image, :remove_sidebar_image, :sidebar_image_cache, :url, :priority, :active)
    end
end
