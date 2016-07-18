class Webmaster < User

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products

  default_scope { where('admin = ?', false) }



end
