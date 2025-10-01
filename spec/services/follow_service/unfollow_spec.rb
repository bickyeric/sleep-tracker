require 'rails_helper'

RSpec.describe FollowService::Unfollow do
  let(:user) { create(:user) }
  let(:followed) { create(:user) }
  let!(:follow) { create(:follow, follower_id: user.id, followee_id: followed.id) }

  subject { FollowService.unfollow(user: user, followed_user_id: followed.id) }

  context 'when already unfollowed' do
    before { follow.destroy }

    it 'nothing changes' do
      expect(followed.followers).to be_empty
      expect { subject }.not_to raise_error
      expect(followed.followers).to be_empty
    end
  end

  context 'when success unfollow user' do
    it 'raise user not found error' do
      expect { subject }.not_to raise_error
      expect(followed.followers).to be_empty
    end
  end
end 
