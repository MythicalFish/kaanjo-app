class ReactionsController < ApplicationController

  def create
    if Reaction.create(params)
      render json: {success:true}
    else
      render json: {success:false}
    end
  end

end
