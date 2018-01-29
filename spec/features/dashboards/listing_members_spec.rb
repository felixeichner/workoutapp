require 'rails_helper'

RSpec.feature "Listing Members" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		@sarah = User.create!(name: "Sarah", email: "sarah@mail.com", password: "password")
		login_as @john
	end

	scenario "shows a list of registered members" do
		visit "/"
		expect(page).to have_content "List of Members"
		expect(page).to have_content @john.name
		expect(page).to have_content @sarah.name
	end
end