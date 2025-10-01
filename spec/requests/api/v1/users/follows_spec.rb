require 'rails_helper'

RSpec.describe Api::V1::Users::FollowsController, type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => user.id } }
  
  describe 'POST /api/v1/users/:id/follow' do
    let(:followed_user) { create(:user) }

    context 'when success following user' do
      it 'return success status' do
        post api_v1_user_follow_path(followed_user.id), headers: headers

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('success')
        expect(user.following).to include(followed_user)
      end
    end

    context 'when follow themself' do
      it 'returns error' do
        post api_v1_user_follow_path(user.id), headers: headers

        expect(response).to have_http_status(:unprocessable_content)
        expect(JSON.parse(response.body)['errors'][0]['message']).to eq('cannot follow yourself')
      end
    end

    context 'when follow not found user' do
      it 'returns not found user error' do
        post api_v1_user_follow_path(9726), headers: headers

        expect(response).to have_http_status(:unprocessable_content)
        expect(JSON.parse(response.body)['errors'][0]['message']).to eq('user not found')
      end
    end
  end

  describe 'POST /api/v1/users/:id/follow' do
    let(:followed_user) { create(:user) }

    context 'when success unfollow user' do
      before { create(:follow, follower_id: user.id, followee_id: followed_user.id) }
      it 'return success status' do
        delete api_v1_user_follow_path(followed_user.id), headers: headers

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('success')
        expect(user.following).to be_empty
      end
    end

    context 'when user already unfollowed' do
      it 'return success status' do
        expect(user.following).to be_empty
        delete api_v1_user_follow_path(followed_user.id), headers: headers

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('success')
        expect(user.following).to be_empty
      end
    end
  end
end
