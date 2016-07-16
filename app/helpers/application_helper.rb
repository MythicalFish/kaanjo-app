module ApplicationHelper

  def current_webmaster
    if current_user && current_user.webmaster?
      Webmaster.find(current_user.id)
    end
  end

end
