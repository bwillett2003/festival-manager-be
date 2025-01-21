class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    users = User.all
    render json: UserSerializer.new(users).serializable_hash.to_json, status: :ok
  end

  def show
    user = User.includes(schedules: :shows).find(params[:id])
    render json: UserSerializer.new(user).serializable_hash.to_json, status: :ok
  end

  private

  def record_not_found
    render json: { error: "User not found" }, status: :not_found
  end
end
