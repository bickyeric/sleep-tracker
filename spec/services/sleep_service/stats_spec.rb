require 'rails_helper'

RSpec.describe SleepService::Stats do
  let(:user) { create(:user) }

  subject { SleepService.stats(user: user, period: 1.month) }

  context 'when success build stats' do
    before do
      create(:sleep_summary, user_id: user.id, date: Date.yesterday, total_sleep_duration_minutes: 120, total_sleep_sessions: 1)
      create(:sleep_summary, user_id: user.id, date: Date.today, total_sleep_duration_minutes: 30, total_sleep_sessions: 1)
    end

    it 'raise active sleep error' do
      expect(subject[:total_sleep_duration_minutes]).to eq(150)
      expect(subject[:total_days]).to eq(2)
      expect(subject[:total_number_of_sleep_sessions]).to eq(2)
      expect(subject[:total_sleep_duration_hours]).to eq(2)
    end
  end
end
