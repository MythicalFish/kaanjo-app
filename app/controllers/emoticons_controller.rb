class EmoticonsController < ApplicationController

  include EnforceAdmin

  def index
    @title = "Emoticons"
    @emoticons = Emoticon.all
  end

  def edit
    @emoticon = Emoticon.find(params[:id])
    @title = @emoticon.label
  end

  def new
    @emoticon = Emoticon.new
    @title = "New emoticon"
  end

  def update

    @emoticon = Emoticon.find(params[:id])

    if @emoticon.update_attributes(emoticon_params)
      flash[:notice] = 'Emoticon updated'
    else
      flash[:alert] = "Error: #{@emoticon.errors.full_messages.to_sentence}"
    end

    redirect_to emoticons_path

  end

  def create

    @emoticon = Emoticon.new(emoticon_params)

    if @emoticon.save
      flash[:notice] = "Emoticon created"
      redirect_to emoticons_path
    else
      flash[:alert] = "Emoticon creation failed: #{@emoticon.errors.full_messages.to_sentence}"
      respond_with @emoticon, location: new_emoticon_path
    end

  end

  private

  def emoticon_params
    params.require(:emoticon).permit(:label, :image, :category)
  end

end