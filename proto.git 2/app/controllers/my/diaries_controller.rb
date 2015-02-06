class My::DiariesController < MyController
  before_action :set_diary, only: [:edit, :update, :destroy]

  def new
    @diary = Diary.new
  end

  def edit
  end

  def create
    diary = Diary.new permit_params
    diary.writer = current_user

    if diary.save
      redirect_to diary, notice: '日記を登録しました。'
    else
      render 'new'
    end
  end

  def update
    if @diary.update(permit_params)
      redirect_to @diary, notice: '日記を編集しました。'
    else
      render 'diaries/edit'
    end
  end

  def destroy
    @diary.destroy
    redirect_to my_profile_index_url, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_diary
    @diary = Diary.find params[:id]
  end

  def permit_params
    params.require(:diary).permit(:title, :body, :range, images_attributes: [:src])
  end
end
