class Admin::EvaluationsController < AdminController

  def index
    @categories = TagGroup.category.tags.root
  end

  def edit
    @tag = Tag.find params[:id]
    @tag.build_evaluations
  end

  def update
    @tag = Tag.find params[:id]
    @tag.update permit_params

    if @tag.save
      flash[:notice] = '評価項目を更新しました'
    else
      flash[:alert] = '評価項目の更新に失敗しました'
    end

    redirect_to admin_category_url(@tag)
  end

  private

  def permit_params
    params.require(:tag).permit evaluations_attributes: [:id, :name, :priority]
  end
end
