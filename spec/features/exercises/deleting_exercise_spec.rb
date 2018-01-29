require 'rails_helper'

RSpec.feature "Deleting Exercise" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		login_as @john
		@exercise = @john.exercises.create!(workout: "Running",
																				workout_date: Date.today-5, duration_in_min: 50)
	end

	scenario "A user deletes an exercise" do
		visit "/users/#{@john.id}/exercises"
		expect {
			click_link "Delete"
		}.to change(Exercise, :count).by(-1)

		expect(current_path).to eq user_exercises_path(@john)
		expect(page).to have_content "Workout has been deleted"
		expect(page).not_to have_content "Running"
	end	
end