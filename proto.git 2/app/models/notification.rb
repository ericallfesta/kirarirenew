class Notification < ActiveRecord::Base
  belongs_to :noticeable, :polymorphic => true
  belongs_to :user

  default_scope -> { order created_at: :desc }

  validates_presence_of :body
  validates_format_of :url, with: /\A(\/[a-z0-9]+)+\z/, allow_blank: true

  before_save :default_values

  def default_values
    self.status ||= 'unread'
  end

  class << self
    def publish args = {}
      delegate = args[:delegate]
      body = delegate.notification[:body]
      icon = delegate.notification[:icon]
      url = delegate.notification[:url]

      self.publish_target(delegate).each do |user_id|
        self.create( body: body, url: url, user_id: user_id, icon: icon, noticeable: delegate )
      end
    end

    def publish_target delegate
      if delegate.respond_to? :notice_for
        delegate.send(:notice_for)
      else
        logger.warn "notice_for is not found"
        []
      end
    end

    def all_read user
      self.where( user_id: user.id, status: 'unread' ).each do |notification|
        notification.update( status: 'read' )
      end
    end

    def weekly(where=nil)
      _ = {}
      self.where(where).where(created_at: (Time.now.midnight-6.days+1)..(Time.now.midnight+1.days)).each do |n|
        _[n.created_at.strftime('%Y%m%d')] ||= []
        _[n.created_at.strftime('%Y%m%d')] << n
      end
      _
    end

    def clean
      self.delete(self.where("created_at < ?", (Time.now.midnight-6.days+1)).pluck(:id))
    end
  end
end
