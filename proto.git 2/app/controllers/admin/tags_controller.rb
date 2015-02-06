class Admin::TagsController < AdminController
  before_action :set_tag, only: [:show, :edit, :update]

  def index
    @tags = Tag.where.not(group: TagGroup.category).page params[:page]
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = TagGroup.find(tag_params[:group]).tags.build tag_params.merge(body_parts: BodyPart.find(tag_params[:body_parts])).except(:group)

    if @tag.save
      redirect_to [:admin, :tags], notice: 'タグを追加しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.update tag_params.merge({ group: TagGroup.find(tag_params[:group]), body_parts: BodyPart.find(tag_params[:body_parts]) })
      redirect_to [:admin, :tags], notice: 'タグを編集しました'
    else
      render :edit
    end
  end

  private

  def set_tag
    @tag = Tag.find params[:id]
  end

  def tag_params
    params.require(:tag).permit :name, :group, body_parts: []
  end
end
