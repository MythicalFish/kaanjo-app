module UserHelper

  def current_admin
    if current_user && current_user.admin?
      Admin.find(current_user.id)
    end
  end

  def current_webmaster
    if current_user && current_user.webmaster?
      Webmaster.find(current_user.id)
    end
  end

  def admin?
    !current_admin ? false : true
  end

  def webmaster?
    !current_webmaster ? false : true
  end

end  
