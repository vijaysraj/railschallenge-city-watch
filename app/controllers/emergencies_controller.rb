class EmergenciesController < ApplicationController

  rescue_from ActionController::UnpermittedParameters, with: :catch_unpermitted_params

  def create
    @emergency = Emergency.new(emergency_params)
    if @emergency.save
      render json: { emergency: @emergency }, status: 201
    else
      render json: { message: @emergency.errors }, :status: 422
    end
  end

  def index
    @emergencies = Emergency.all
    render json: {emergencies: @emergencies}
  end

  def update
    @emergency = Emergency.find_by_code(params[:code])
    if @emergency.update_attributes(emergency_update_params)
      render json: { emergency: @emergency }, status: 201
    else
      render json: { message: @emergency.errors }, status: 422
    end
  end

  private

  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end

  def emergency_update_params
    params.require(:emergency).permit(:fire_severity, :police_severity, :medical_severity, :resolved_at)
  end

  def catch_unpermitted_params
    render :json => { message: $ERROR_INFO.message }.to_json, :status => 422
  end

end