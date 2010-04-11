module UsersHelper

  def friend_with?(user)
    @current_user.friend_with?(user)
  end

  def friendship_icon(img, title)
    image_tag(img, :alt => title, :class => "round")
  end
end
