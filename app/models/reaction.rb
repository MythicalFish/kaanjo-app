class Reaction < ActiveRecord::Base

  belongs_to :product
  belongs_to :reaction_type
  belongs_to :customer

  alias_method :type, :reaction_type


end
