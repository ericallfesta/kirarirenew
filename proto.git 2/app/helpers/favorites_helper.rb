module FavoritesHelper
  def fav_button target
    if ! logged_in?
      ''
    elsif target.is_a? User
      generate_fav_button(target, target == current_user) 
    elsif target.kind_of? Writing
      generate_fav_button(target, target.writer == current_user)
    else
      ''
    end
  end

  private

  def generate_fav_button target, tomyself
    class_list = 'btn btn-kirari'
    count = target.favorites.count
    if tomyself
      class_list += ' done me'
      if target.is_a? User
        label = content_tag :span, t('views.kirari_button.myself'), class: 'msg'
      else
        label = content_tag :span, t('views.kirari_button.my_writing'), class: 'msg'
      end
    else
      if target.is_faved? current_user
        label = content_tag :span, t('views.kirari_button.done'), class: 'msg'
        class_list += ' done'
      else
        label = content_tag :span, t('views.kirari_button.send'), class: 'msg'
      end
    end

    # User-list
    target_id = 'fav-user-list-' + target.object_id.to_s
    user_list = '';
    target.favorite_users.each do |user|
      image = image_tag user.image.thumbnail, width: 24, height: 24, alt: ''
      user_list += '<li>' + link_to(image + user.display_name, user, class: 'force-link') + '</li>'
    end

    if user_list.empty?
      user_list = '<p>' + t('messages.no_kirari') + '</p>'
    else
      user_list = "<p>キラリを贈ったユーザー</p><ul>" + user_list + "</ul>"
    end

    user_list = "<div class=\"users\" id=\"#{target_id}\">" + user_list + "</div>"

    button = link_to "#{icon :kirari} #{label}".html_safe, [target, 'favorites'], class: class_list, :'krr-view' => 'KirariButtonView'
    count = "<span class=\"count show-tooltip tooltip-top open-by-click\" data-tooltip-target=\"#{target_id}\" data-append-local=\"true\" data-offset-left=\"7\" data-width=\"170\" data-classname=\"kirari-user-list\" data-autohide=\"300\">#{count}</span>"

    raw ('<div class="krr-btn-container">' + button + count + user_list + '</div>')
  end
end
