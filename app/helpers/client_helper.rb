module ClientHelper
  
  def button_class r
    "selected" if r == @reaction_type
  end

end
