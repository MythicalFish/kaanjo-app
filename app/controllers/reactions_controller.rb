class ReactionsController < ApplicationController

  def create
    if Reaction.create(reaction_params)
      render json: {success:true}
    else
      render json: {success:false}
    end
  end

  def reaction_params
    params.require(:reaction).permit(:name,:referrer)
  end

end
