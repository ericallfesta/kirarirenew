module Following
  extend ActiveSupport::Concern

  included do
    def self.follow(followable)
      follows.create( followable: followable )
    end
  end
end
