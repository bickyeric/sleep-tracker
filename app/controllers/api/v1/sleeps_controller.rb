class Api::V1::SleepsController < ApplicationController
  def create
    sleep = SleepService.start(user: current_user)

    render json: { message: 'sleep started', data: sleep }, status: :ok
  rescue SleepService::ActiveSleepExistError => e
    render json: {errors: [{message: e.message}]}, status: :conflict
  end

  def end
    sleep = SleepService.end(user: current_user, sleep_id: params[:sleep_id])

    render json: { message: 'sleep ended', data: sleep }, status: :ok
  rescue SleepService::SleepEndedError => e
    render json: {errors: [{message: e.message}]}, status: :unprocessable_entity
  rescue SleepService::SleepNotFoundError => e
    render json: {errors: [{message: e.message}]}, status: :not_found
  end
end
