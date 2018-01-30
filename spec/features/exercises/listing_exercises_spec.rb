require 'rails_helper'

RSpec.feature "Listing Exercises" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		@sarah = User.create!(name: "Sarah", email: "sarah@mail.com", password: "password")
		login_as @john
		@exercise1 = @john.exercises.create(workout: "Running",
																				workout_date: Date.today, duration_in_min: 10)
		@exercise2 = @john.exercises.create(workout: "Cycling",
																				workout_date: Date.today-7, duration_in_min: 20)
		@exercise3 = @john.exercises.create(workout: "Bodypump class",
																				workout_date: Date.today-8, duration_in_min: 30)
		@exercise4 = @sarah.exercises.create(workout: "Weight lifting",
																				workout_date: Date.today-2, duration_in_min: 40)
		@exercise5 = @sarah.exercises.create(workout: "Squash",
																				workout_date: Date.today-6, duration_in_min: 50)
		@exercise6 = @sarah.exercises.create(workout: "Treadmill",
																				workout_date: Date.today-9, duration_in_min: 60)
		@john.friendships.create!(friend_id: @sarah.id)
		@sarah.friendships.create!(friend_id: @john.id)	
	end

	scenario "A user lists exercises of last seven days" do
		visit "/users/#{@john.id}/exercises"

		expect(page).to have_content @exercise1.workout
		expect(page).to have_content @exercise1.workout_date.strftime("%d. %b %Y")
		expect(page).to have_content @exercise1.duration_in_min
		expect(page).to have_link("Show", href: "/users/#{@john.id}/exercises/#{@exercise1.id}")
		expect(page).to have_link("Edit", href: "/users/#{@john.id}/exercises/#{@exercise1.id}/edit")
		expect(page).to have_link("Delete", href: "/users/#{@john.id}/exercises/#{@exercise1.id}")

		expect(page).to have_content @exercise2.workout

		expect(page).not_to have_content @exercise3.workout
		expect(page).not_to have_content @exercise4.workout
		expect(page).not_to have_content @exercise5.workout
		expect(page).not_to have_content @exercise6.workout
	end

	scenario "A user has no exercises to list" do
		@john.exercises.delete_all

		visit "/users/#{@john.id}/exercises"

		expect(page).to have_content "There are no workouts to list"
	end

	scenario "A user lists exercises of followed user" do
		visit "/users/#{@john.id}/exercises"
		find("a[href='/users/#{@sarah.id}/exercises']").click

		expect(page).to have_content @exercise4.workout
		expect(page).to have_content @exercise4.workout_date.strftime("%d. %b %Y")
		expect(page).to have_content @exercise4.duration_in_min
		expect(page).not_to have_link("Show", href: "/users/#{@sarah.id}/exercises/#{@exercise4.id}")
		expect(page).not_to have_link("Edit", href: "/users/#{@sarah.id}/exercises/#{@exercise4.id}/edit")
		expect(page).not_to have_link("Delete", href: "/users/#{@sarah.id}/exercises/#{@exercise4.id}")

		expect(page).to have_content @exercise5.workout

		expect(page).not_to have_content @exercise6.workout
		expect(page).not_to have_content @exercise1.workout
		expect(page).not_to have_content @exercise2.workout
		expect(page).not_to have_content @exercise3.workout
	end

end