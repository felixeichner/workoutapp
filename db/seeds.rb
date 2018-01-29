User.create!(name: "Felix", email: "felix@mail.com", password: "111111")
User.create!(name: "Anna", email: "anna@mail.com", password: "111111")
User.create!(name: "Michael", email: "michael@mail.com", password: "111111")
User.create!(name: "Peter", email: "peter@mail.com", password: "111111")

User.all.each do |user|
		user.exercises.create!(workout: "Running", workout_date: Date.today, duration_in_min: 60)
		user.exercises.create!(workout: "Cycling", workout_date: 3.days.ago, duration_in_min: 90)
		user.exercises.create!(workout: "Bodypump", workout_date: 5.days.ago, duration_in_min: 50)
		user.exercises.create!(workout: "undisplayed workout because too long ago",
													 workout_date: 8.days.ago, duration_in_min: 70)
end