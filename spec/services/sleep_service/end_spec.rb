require 'rails_helper'

RSpec.describe SleepService::End do
  let(:user) { create(:user) }
  let(:sleep) { create(:sleep, user: user) }

  subject { SleepService.end(user: user, sleep_id: sleep.id) }

  context 'when active sleep is not found' do
    subject { SleepService.end(user: user, sleep_id: 23480) }

    it 'raise active sleep not found error' do
      expect { subject }.to raise_error(SleepService::SleepNotFoundError)
    end
  end

  context 'when sleep is already ended' do
    let(:sleep) { create(:sleep, user: user, sleep_end: Time.now) }

    it 'raise sleep already ended error' do
      expect { subject }.to raise_error(SleepService::SleepEndedError)
    end
  end

  context 'when success end sleep record' do
    before { create(:sleep, user_id: user.id, sleep_start: Time.now) }

    it 'not raise error' do
      expect { subject }.not_to raise_error
    end
  end
end
