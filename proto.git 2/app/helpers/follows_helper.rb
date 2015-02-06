module FollowsHelper
  def user_follow_path user
    "/users/#{user.id}/follow"
  end
end
