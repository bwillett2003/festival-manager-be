class Api::V1::SchedulesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    schedules = Schedule.all
    render json: ScheduleSerializer.new(schedules).serializable_hash.to_json, status: :ok
  end

  def show
    schedule = Schedule.includes(:shows).find(params[:id])
    render json: ScheduleSerializer.new(schedule).serializable_hash.to_json, status: :ok
  end

  def destroy
    schedule_show = ScheduleShow.find_by!(schedule_id: params[:schedule_id], show_id: params[:show_id])
    schedule_show.destroy
    render json: { message: 'Show removed from schedule successfully' }, status: :ok
  end

  private

  def record_not_found
    render json: { error: "Record not found" }, status: :not_found
  end
end