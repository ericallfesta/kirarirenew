class ReportsController < ApplicationController
  before_filter :require_login, only: %w[new create edit update destroy]
  before_filter :refuse_guest, only: %w[new create edit update destroy]
  before_filter :set_report, only: %w[show redirect edit update destroy]
  before_filter :meta_noindex, only: %w[new edit]

  def show
    check_notification(@report)
    @report.comments.each { |c| check_notification(c) }
  end

  def new
    @report = Report.new(product_id: params[:product_id])
    @report.inspect
    @report.build_images
    @report.build_evaluations
  end

  def edit
  end

  def create
    @report = Report.new creating_params
    @report.writer_id = @current_user.id

    if @report.save
      redirect_to @report
    else
      @report.build_images
      @report.build_evaluations
      render :new
    end
  end

  def update
    return redirect_to root_path if @report.writer_id != @current_user.id

    if @report.update_attributes(updating_params)
      redirect_to @report
    else
      render :edit
    end
  end

  def destroy
    return redirect_to root_path if @report.writer_id != @current_user.id

    user = @report.writer
    @report.destroy
    redirect_to user
  end

  def redirect
    redirect_to @report
  end

  private

  def creating_params
    params.require(:report).permit(
      :body, :title, :star, :product_id,
      efficacy_ids: [],
      detail_attributes: [:use_times, :use_type, :bought_place],
      report_evaluations_attributes: [:id, :star, :evaluation_id],
      images_attributes: [:id, :src, :_destroy]
    )
  end

  def updating_params
    params.require(:report).permit(:body, :title, :star)
  end

  def set_report
    @report = Report.find params[:id]
    @meta = @report.to_meta
  end
end
