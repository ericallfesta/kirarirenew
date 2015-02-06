module Permission
  def refuse_guest
    not_permitted if logged_in? && current_user.is_guest?
  end
end
