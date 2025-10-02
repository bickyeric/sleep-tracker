require 'rails_helper'

RSpec.describe UpsertSleepSummaryJob, type: :job do
  let(:user) { create(:user) }

  describe '#perform' do
    it 'call service object with correct params' do
      expect_any_instance_of(SleepService::UpsertSummary).to receive(:perform)

      UpsertSleepSummaryJob.perform_now(user.id, Date.current)
    end
  end
end
