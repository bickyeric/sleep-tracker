require 'rails_helper'

RSpec.describe FollowService::Follow do
  let(:user) { create(:user) }
  let(:followed) { create(:user) }

  subject { FollowService.follow(user: user, followed_user_id: followed.id) }

  context 'when follow themself' do
    subject { FollowService.follow(user: user, followed_user_id: user.id) }

    it 'raise self follow error' do
      expect { subject }.to raise_error(FollowService::SelfFollowError)
    end
  end

  context 'when follow unexisted user' do
    let(:followed) { User.new(id: 890)}

    it 'raise user not found error' do
      expect { subject }.to raise_error(FollowService::UserNotFoundError)
    end
  end

  context 'when user already followed' do
    before { create(:follow, follower_id: user.id, followee_id: followed.id) }

    it 'not raise error' do
      expect { subject }.not_to raise_error
    end
  end

  context 'when success follow user' do
    it 'not raise error' do
      expect { subject }.not_to raise_error
      expect(followed.followers).to include(user)
    end
  end
end 
