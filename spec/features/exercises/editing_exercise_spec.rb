require 'rails_helper'

RSpec.feature "Editing Exercise" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		login_as @john
		@exercise = @john.exercises.create!(workout: "Running",
																				workout_date: Date.today-5, duration_in_min: 50)
	end

	scenario "with valid credentials" do
		visit "/users/#{@john.id}/exercises"
		find("a[href=\'/users/#{@john.id}/exercises/#{@exercise.id}/edit\']").click

		fill_in "Workout details", with: "Cycling"
		fill_in "Activity date", with: Date.today
		fill_in "Duration (min)", with: 60
		click_button "Update Workout"

		expect(current_path).to eq user_exercise_path(@john, @exercise)
		expect(page).to have_content "Workout has been updated"
		expect(page).to have_content "Cycling"
		expect(page).to have_content Date.today.strftime("%d. %b %Y")
		expect(page).to have_content "60"
		expect(page).not_to have_content "Running"
		expect(page).not_to have_content Date.today-5
		expect(page).not_to have_content "50"
	end

	scenario "with invalid credentials" do
		visit "/users/#{@john.id}/exercises"
		click_link "Edit"

		fill_in "Workout details", with: ""
		fill_in "Activity date", with: ""
		fill_in "Duration (min)", with: 0
		click_button "Update Workout"

		expect(page).to have_content "prohibited the workout from being saved"
		expect(page).to have_content "Update workout for #{@john.name}"
		expect(page).to have_content "Activity date can't be blank"
		expect(page).to have_content "Workout details can't be blank"
	end
end