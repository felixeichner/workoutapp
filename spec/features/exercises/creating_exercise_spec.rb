require 'rails_helper'

RSpec.feature "Creating Excercise" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		login_as @john
		visit "/"
		click_link "My Lounge"
		click_link "New Workout"
	end

	scenario "with valid credentials" do
		fill_in "Duration (min)", with: "40"
		fill_in "Workout details", with: "Bodypump"
		fill_in "Activity date", with: "01/01/2018"
		expect(page).to have_link "Back"
		expect {
			click_button "Create Workout"
		}.to change(Exercise, :count).by(1)

		expect(Exercise.last.user_id).to eq @john.id
		expect(current_path).to eq user_exercise_path(@john, Exercise.last)
		expect(page).to have_content "Workout has been created"
	end

	scenario "with invalid credentials" do
		fill_in "Duration (min)", with: "0"
		fill_in "Workout details", with: ""
		fill_in "Activity date", with: "dd/mm/yyyy"
		expect(page).to have_link "Back"
		expect {
			click_button "Create Workout"
		}.to change(Exercise, :count).by(0)

		expect(page).to have_content "prohibited the workout from being saved"
		expect(page).to have_content "New workout for #{@john.name}"
		expect(page).to have_content "Activity date can't be blank"
		expect(page).to have_content "Workout details can't be blank"
	end
end