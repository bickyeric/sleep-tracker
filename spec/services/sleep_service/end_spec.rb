require 'rails_helper'

RSpec.describe SleepService::End do
  let(:user) { create(:user) }

  subject { SleepService.end(user: user) }

  context 'when active sleep is not found' do

    it 'raise active sleep not found error' do
      expect { subject }.to raise_error(SleepService::ActiveSleepNotFoundError)
    end
  end

  context 'when success end sleep record' do
    before { create(:sleep, user_id: user.id, sleep_start: Time.now) }

    it 'not raise error' do
      expect { subject }.not_to raise_error
    end
  end
end
