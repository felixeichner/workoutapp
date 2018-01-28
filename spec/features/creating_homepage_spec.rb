require 'rails_helper'

RSpec.feature "Creating Home page" do
	scenario "A user visits the landing page" do
		visit "/"

		expect(page).to have_link "Athletes Den"
		expect(page).to have_link "Home"
		expect(page).to have_content "Workout Lounge!"
		expect(page).to have_content "Show off your workout to your friends"
	end
end