module ApplicationHelper

  def current_webmaster
    if current_user && current_user.webmaster?
      Webmaster.find(current_user.id)
    end
  end

  def cp(path)
    "current" if current_page?(path)
  end

end
