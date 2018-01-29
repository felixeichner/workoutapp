require 'rails_helper'

RSpec.feature "Listing Exercises" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		login_as @john
		@exercise1 = @john.exercises.create(workout: "Running",
																				workout_date: Date.today, duration_in_min: 60)
		@exercise2 = @john.exercises.create(workout: "Cycling",
																				workout_date: 7.days.ago, duration_in_min: 90)
		@exercise3 = @john.exercises.create(workout: "Bodypump class",
																				workout_date: 8.days.ago, duration_in_min: 50)
	end

	scenario "A user lists exercises of last seven days" do
		visit "/users/#{@john.id}/exercises"

		expect(page).to have_content @exercise1.workout
		expect(page).to have_content @exercise1.workout_date
		expect(page).to have_content @exercise1.duration_in_min

		expect(page).to have_content @exercise2.workout
		expect(page).to have_content @exercise2.workout_date
		expect(page).to have_content @exercise2.duration_in_min

		expect(page).not_to have_content @exercise3.workout
		expect(page).not_to have_content @exercise3.workout_date
		expect(page).not_to have_content @exercise3.duration_in_min
	end

	scenario "A user has no exercises to list" do
		@john.exercises.delete_all

		visit "/users/#{@john.id}/exercises"

		expect(page).to have_content "There are no workouts to list"
	end
end