FactoryBot.define do
  factory :sleep do
    sleep_start { Time.now }
  end
end
