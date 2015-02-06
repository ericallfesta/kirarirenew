class My::FollowsController < FollowsController
  before_action :set_target, only: [:followers, :following]

  protected
    def set_target
      @target = current_user
    end
end
