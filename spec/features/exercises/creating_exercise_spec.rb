require 'rails_helper'

RSpec.feature "Creating Excercise" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		login_as @john
	end

	scenario "with valid credentials" do
		visit "/"
		click_link "My Lounge"
		click_button "New Exercise"

		fill_in "Duration", with: "40"
		fill_in "Workout details", with: "Bodypump"
		fill_in "Date", with: DateTime.now.strftime("%d.%m.%Y")
		expect(page).to have_link "Back"
		expect {
			click_button "Create Exercise"
		}.to change(Exercise, :count).by(1)

		expect(Exercise.last.user_id).to eq @john.id
		expect(current_path).to eq user_exercise_path(@john, Exercise.last)
		expect(page).to have_content "Exercise has ben created"
	end
end