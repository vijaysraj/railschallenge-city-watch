class ResponderController < ApplicationController

  def create
    @responder = Responder.new(responder_params)  
    if responder.save
      render json: {responder: @responder}, status: 201
    else
      render json: {message: @responder.errors}, status: 201
    end
  end

  private

  def responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end

end