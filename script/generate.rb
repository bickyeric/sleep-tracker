
# generate user
100.times do
  User.create(name: Faker::Name.name)
end

# generate following relationship
User.pluck(:id).each do |user_id|
  10.times do
    Follow.create(follower_id: user_id, followee_id: rand(1..100))
  end
end

