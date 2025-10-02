require 'rails_helper'

RSpec.describe SleepService::UpsertSummary do
  let(:user) { create(:user) }
  let(:date) { Date.current }

  subject { SleepService.upsert_summary(user: user, date: date) }

  describe 'when sleep summary created' do
    context 'when user has no sleep' do
      it 'create sleep summary' do
        is_expected.to have_attributes(:total_sleep_sessions => 0)
        is_expected.to have_attributes(:total_sleep_duration_minutes => 0)
      end
    end

    context 'when user have sleeps' do
      before do
        create(:sleep, user: user, sleep_start: date.beginning_of_day + 1.hour, sleep_end: date.beginning_of_day + 2.hour)
        create(:sleep, user: user, sleep_start: date.beginning_of_day + 2.hour, sleep_end: date.beginning_of_day + 3.hour)
        create(:sleep, user: user, sleep_start: date.beginning_of_day + 3.hour)
      end

      it 'create sleep summary' do
        is_expected.to have_attributes(:total_sleep_sessions => 2)
        is_expected.to have_attributes(:total_sleep_duration_minutes => 120)
      end
    end
  end
end
