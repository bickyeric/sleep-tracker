require 'rails_helper'

RSpec.describe SleepService::Start do
  let(:user) { create(:user) }

  subject { SleepService.start(user: user) }

  context 'when active sleep is exist' do
    before { create(:sleep, user_id: user.id, sleep_start: Time.now) }

    it 'raise active sleep error' do
      expect { subject }.to raise_error(SleepService::ActiveSleepExistError)
    end
  end

  context 'when success create sleep record' do
    it 'not raise error' do
      expect { subject }.not_to raise_error
    end
  end
end
