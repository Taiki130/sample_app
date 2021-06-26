User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

users = (0...99).map do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = 'password'
  User.new(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    admin: false,
    activated: true,
    activated_at: Time.zone.now
  )
end
User.import users

users = User.order(:created_at).take(6)
users.each do |user|
  contents = (0...50).map do
    { content: Faker::Lorem.sentence(word_count: 5) }
  end
  microposts = user.microposts.build(contents)
  Micropost.import microposts
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }