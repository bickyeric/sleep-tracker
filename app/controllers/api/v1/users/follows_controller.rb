class Api::V1::Users::FollowsController < ApplicationController
  def create
    FollowService.follow(user: current_user, followed_user_id: params[:user_id])

    render json: {message: 'success'}
  rescue FollowService::SelfFollowError, FollowService::UserNotFoundError => e
    render json: {errors: [{message: e.message}]}, status: :unprocessable_entity
  end

  def destroy
    FollowService.unfollow(user: current_user, followed_user_id: params[:user_id])

    render json: {message: 'success'}
  end
end
