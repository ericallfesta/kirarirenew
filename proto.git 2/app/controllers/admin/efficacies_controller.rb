class Admin::EfficaciesController < AdminController

  def index
    @categories = TagGroup.category.tags.root
  end

  def new
    @tag = Tag.find params[:tag_id]
    @efficacy = @tag.efficacies.build
  end

  def edit
    @efficacy = Efficacy.find params[:id]
  end

  def create
    @tag = Tag.find params[:tag_id]
    @efficacy = @tag.efficacies.build permit_params

    if @efficacy.save
      flash[:notice] = '効果効能を追加しました'
    else
      flash[:alert] = '効果効能の追加に失敗しました'
    end

    redirect_to admin_category_url(@efficacy.category)
  end

  def update
    @efficacy = Efficacy.find params[:id]

    if @efficacy.update permit_params
      flash[:notice] = '効果効能を編集しました'
    else
      flash[:alert] = '効果効能の編集に失敗しました'
    end

    redirect_to admin_category_url(@efficacy.category)
  end

  def destroy
    efficacy = Efficacy.find params[:id]
    category = efficacy.category
    efficacy.delete
    redirect_to admin_category_url(category), notice: '効果効能を削除しました'
  end

  private

  def permit_params
    params.require(:efficacy).permit :name
  end
end
