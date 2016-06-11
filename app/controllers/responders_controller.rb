class RespondersController < ApplicationController
  rescue_from ActionController::UnpermittedParameters, with: :catch_unpermitted_params

  def new
    render json: { message: 'page not found' }, status: 404
  end

  def create
    @responder = Responder.new(responder_params)  
    if @responder.save
      render json: { responder: @responder }, status: 201
    else
      render json: { message: @responder.errors }, status: 422
    end
  end

  def index
    if params[:show] == "capacity"
      @capacity = Responder.capacity
      render :json => { capacity: @capacity }
    else
      @responders = Responder.all
      render :json => { responders: @responders }
    end
  end

  def edit
    render json: { message: 'page not found' }, status: 404
  end

  def update
    @responder = Responder.find_by_name(params[:name])
    if @responder.update_attributes(responder_update_params)
      render json: { responder: @responder }, status: 201
    else
      render json: { message: @responder.errors }, status: 422
    end
  end

  def show
    @responder = Responder.find_by_name(params[:name])
    if @responder.present?
      render json: { responder: @responder }
    else
      render json: {message: 'responder not found'}, status: 404
    end
  end

  def destroy
    render json: { message: 'page not found' }, status: 404
  end

  private

  def responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end

  def responder_update_params
    params.require(:responder).permit(:on_duty)
  end

  def catch_unpermitted_params
    render :json => { message: $ERROR_INFO.message }.to_json, :status => 422
  end
end