class ActivitiesController < ApplicationController
  after_action :meta_noindex
  before_action :set_activities

  def index
    @filter = :all
  end

  def typed
    @filter = params[:type].to_sym
  end

  private

  def set_activities
    if logged_in?
      @activities = current_user.activities.page(1).per(100)
      @reports = current_user.activities(:report).published.page(1).per(100)
      @questions = current_user.activities(:question).published.page(1).per(100)
      @diaries = current_user.activities(:diary).page(1).per(100)
    else
      @activities = Writing.page(1).per(100)
      @reports = Report.published.page(1).per(100)
      @questions = Question.published.page(1).per(100)
      @diaries = Diary.page(1).per(100)
    end
  end
end
