class Admin < User

  before_save :adminify

  default_scope { where('admin = ?', true) }

  def adminify
    self.admin = true
  end

end
