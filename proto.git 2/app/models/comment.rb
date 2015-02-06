class Comment < ActiveRecord::Base
  include Noticeable

  belongs_to :writing
  belongs_to :user

  validates_presence_of :body, :writing, :user

  after_save :update_commented_at_for_writing

  EXCERPT_LENGTH = 45

  def notification_body_attributes
    if body.length >= self.class::EXCERPT_LENGTH
      excerpt = body[0, self.class::EXCERPT_LENGTH] + ' ...'
    else
      excerpt = body
    end
    { name: user.display_name, excerpt: excerpt, body: body }
  end

  def notification_link
    "/#{writing.type.downcase.pluralize}/#{writing.id}"
  end

  def notice_for
    users = [self.user_id, self.writing.writer.id]
    self.writing.comments.each do |comment|
      users << comment.user_id
    end
    users.uniq.delete_if { |v| v == self.user_id }
  end

  private

  def update_commented_at_for_writing
    self.writing.commented_at = Time.now
    self.writing.save
  end
end
