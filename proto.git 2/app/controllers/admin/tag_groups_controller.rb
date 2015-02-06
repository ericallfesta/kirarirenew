class Admin::TagGroupsController < AdminController
  before_action :set_tag_group, only: [:show, :edit, :update]

  def index
    @tag_groups = TagGroup.page params[:page]
  end

  def show
  end

  def new
    @tag_group = TagGroup.new
  end

  def create
    if TagGroup.create tag_group_params
      redirect_to [:admin, :tag_groups], notice: 'タググループを追加しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag_group.update tag_group_params
      redirect_to [:admin, :tag_groups], notice: 'タググループを編集しました'
    else
      render :new
    end
  end

  private

  def set_tag_group
    @tag_group = TagGroup.find params[:id]
  end

  def tag_group_params
    params.require(:tag_group).permit :name, :slug
  end
end
