
# generate user
100.times do
  User.create(name: Faker::Name.name)
end

user_ids = User.pluck(:id)

# generate following relationship
user_ids.each do |user_id|
  10.times do
    Follow.create(follower_id: user_id, followee_id: rand(1..100))
  end
end

user_ids.each do |user_id|
  1_000.times do
    Sleep.create(
      user_id: user_id,
      sleep_start: Faker::Time.between(from: 1.month.ago, to: Time.now),
      sleep_end: Faker::Time.between(from: Time.now, to: 1.day.from_now)
    )
  end
end
