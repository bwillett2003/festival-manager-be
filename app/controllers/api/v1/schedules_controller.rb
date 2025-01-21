class Api::V1::SchedulesController < ApplicationController
  def index
    schedules = Schedule.all
    render json: ScheduleSerializer.new(schedules).serializable_hash.to_json, status: :ok
  end

  def show
    schedule = Schedule.includes(:shows).find(params[:id])
    render json: ScheduleSerializer.new(schedule).serializable_hash.to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Schedule not found" }, status: :not_found
  end
end