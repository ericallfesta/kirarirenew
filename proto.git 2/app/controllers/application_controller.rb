class ApplicationController < ActionController::Base
  include Permission
  include NotificationReader
  include MetaManager

  protect_from_forgery with: :exception
  before_filter :set_sidebar_news
  before_filter :set_sidebar_features
  before_filter :set_sidebar_activities
  before_filter :set_sidebar_diaries
  before_filter :set_sidebar_notifications
  before_filter :set_sidebar_rankings
  before_filter :require_login_on_alpha
  before_filter :set_no_cache

  add_breadcrumb 'TOP', '/'

  %w(admin enterprise).each do |permission|
    define_method "permit_#{permission}" do
      unless self.send("is_#{permission}?")
        redirect_to permission == 'admin' ? admin_login_url : root_url, alert: 'Permission denied.'
      end
    end
  end

  protected

  def is_admin?
    logged_in? && current_user.is_admin?
  end

  def is_enterprise?
    logged_in? && current_user.is_enterprise? && ! current_user.brand.nil?
  end

  def require_login_on_alpha
    self.require_login if ! ENV["KIRARI_VERSION"].nil? && ENV["KIRARI_VERSION"] == 'Alpha'
  end

  def not_authenticated
    redirect_to login_path
  end

  def not_permitted
    respond_to do |format|
      format.json { render status: :forbidden, json: { errors: [I18n.t('messages.not_permitted')] } }
      format.html { not_authenticated }
    end
  end

  private

  def breadlist
    content_for
  end

  def set_sidebar_news
    @sidebar_news = News.published.page(1).per(3)
  end

  def set_sidebar_features
    @sidebar_features = Feature.where active: true
  end

  def set_sidebar_activities
    where = {}
    where = { writer_id: current_user.follows.where( followable_type: 'User' ).map { |follow| follow.followable.id } } if logged_in? && ! current_user.new_record?
    @sidebar_activities = Writing.where(where).page(1).per(5)
  end

  def set_sidebar_diaries
    where = {}
    @sidebar_diaries = Diary.page(1).per(3)
  end

  def set_sidebar_notifications
    @sidebar_notifications = Notification.all.page 1
  end

  def set_sidebar_rankings
    @sidebar_ranking_headline = Product.top(nil, 3).compact
  end

  def set_no_cache
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def self.views_base(path)
    self.class_eval <<-RAILS_EVAL, __FILE__, __LINE__ + 1
      def controller_path
        '#{path}'
      end
    RAILS_EVAL
  end
end
