require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:active_follows).with_foreign_key(:follower_id).class_name('Follow').dependent(:destroy) }
    it { should have_many(:following).through(:active_follows).source(:followee) }

    it { should have_many(:passive_follows).with_foreign_key(:followee_id).class_name('Follow').dependent(:destroy) }
    it { should have_many(:followers).through(:passive_follows).source(:follower) }
  end
end
