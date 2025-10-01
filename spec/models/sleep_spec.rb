require 'rails_helper'

RSpec.describe Sleep, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:sleep_start) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
