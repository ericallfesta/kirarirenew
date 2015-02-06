class Admin::CategoriesController < AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = TagGroup.category.tags.root
  end

  def show
    @category.build_evaluations
  end

  def new
    @category = TagGroup.category.tags.build
  end

  def edit
  end

  def create
    @category = TagGroup.category.tags.build category_params.merge({ parent: Tag.find_by_id(category_params[:parent]) })

    if @category.save
      redirect_to admin_categories_url, notice: 'カテゴリを追加しました'
    else
      render action: 'new'
    end
  end

  def update
    if @category.update category_params.merge({ parent: Tag.find_by_id(category_params[:parent]) })
      redirect_to admin_categories_url, notice: 'カテゴリを編集しました'
    else
      render action: 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_url
  end

  private
    def set_category
      @category = TagGroup.category.tags.find params[:id]
    end

    def category_params
      params.require(:tag).permit :name, :parent
    end
end
