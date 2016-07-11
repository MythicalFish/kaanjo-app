class Webmaster < User

  default_scope { where('admin = ?', false) }

end
