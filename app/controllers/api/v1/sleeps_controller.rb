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

  def index
    cursor = params['cursor'].to_i || 0
    limit = [params['limit']&.to_i || 10, 100].min

    # todo: not optimized yet
    sleeps = Sleep.where(user_id: current_user.id).where('id > ?', cursor).order(:created_at).limit(limit)
    render json: { data: sleeps }
  end

  def friend_feeds
    sleeps = SleepService.friend_feed(user: current_user)

    render json: {
      data: ActiveModel::Serializer::CollectionSerializer.new(sleeps, serializer: SleepSerializer),
      meta: {
        cached: true
      }
    }
  end

  def stats
    render json: { data: SleepService.stats(user: current_user, period: 1.month) }
  end
end
