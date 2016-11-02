module ReactionHelper

  def reaction_attributes r
    {
      id: r.id,
      label: r.label,
      message: r.message
    }
  end

end