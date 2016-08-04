class Product < ActiveRecord::Base

  include ReactionQueries

  has_many :impressions
  has_many :reactions
  belongs_to :webmaster
  before_create :generate_sid 

  scope :by_date, -> { order('created_at DESC') }

  def self.top_by_reaction_type from, to
      select( "products.*, 
              COUNT(reactions.id) AS count,
              reaction_types.name AS type_name" ).
      joins(  :reactions ).
      joins(  "LEFT JOIN reaction_types ON reactions.reaction_type_id = reaction_types.id" ).
      where(  "reactions.created_at" => from..to ).
      group(  "reactions.reaction_type_id" ).
      order(  "count DESC")
  end

  private

  def generate_sid
    begin
      secure_id = SecureRandom.hex(12)
    end while Product.where(:sid => secure_id).exists?
    self.sid = secure_id
  end

end
