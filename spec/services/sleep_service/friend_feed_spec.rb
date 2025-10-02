require 'rails_helper'

RSpec.describe SleepService::FriendFeed do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let!(:friend_sleeps) { create(:sleep, user: friend, created_at: 1.day.ago, sleep_end: Time.now) }

  before { FollowService.follow(user: user, followed_user_id: friend.id) }

  subject { SleepService.friend_feed(user: user) }

  describe 'when user have friend' do
    context 'when friend have sleeps' do
      it "returns friend's sleep records" do
        is_expected.to have_attributes(:size => 1)
      end
    end
  end
end
