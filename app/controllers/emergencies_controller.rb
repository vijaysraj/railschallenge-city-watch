class EmergenciesController < ApplicationController

  rescue_from ActionController::UnpermittedParameters, with: :catch_unpermitted_params

  def create
    @emergency = Emergency.new(emergency_params)
    if @emergency.save
      render json: {emergency: @emergency}, status: 201
    else
      render json: {message: @emergency.errors}, status: 422
    end
  end

  private

  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end

  def catch_unpermitted_params
    render :json => { message: $ERROR_INFO.message }.to_json, :status => 422
  end

end