module MetaManager
  extend ActiveSupport::Concern

  included do
    before_action :set_default_meta_control
  end

  def meta_noindex
    set_default_meta_control if @meta.nil?
    @meta.index = false
  end

  def meta_nofollow
    set_default_meta_control if @meta.nil?
    @meta.follow = false
  end

  def set_default_meta_control
    @meta ||= MetaControl.new description: t('views.site_copy'), index: true, follow: true
  end
end
