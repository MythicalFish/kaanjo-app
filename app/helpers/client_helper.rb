module ClientHelper
  
  def button_class r
    c = "kaanjo-reaction"
    c << " kaanjo-selected" if r == @reaction_type
    c
  end

end
