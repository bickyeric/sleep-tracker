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

    sleeps = Sleep.where(user_id: current_user.id).where('id > ?', cursor).order(:created_at).limit(limit)
    render json: { data: sleeps }
  end

  def friend_feeds
    cursor = params['cursor'].to_i || 0
    limit = [params['limit']&.to_i || 10, 50].min

    sleeps = Sleep.includes(:user)
                .where(user: current_user.following)
                .where(created_at: 1.week.ago..Time.current)
                .where.not(sleep_end: nil)
                .order(:duration_seconds)
                .where('duration_seconds > ?', cursor)
                .limit(limit)

    render json: {
      data: ActiveModel::Serializer::CollectionSerializer.new(sleeps, serializer: SleepSerializer)
    }
  end

  def stats
    render json: { data: SleepService.stats(user: current_user, period: 1.month) }
  end
end
