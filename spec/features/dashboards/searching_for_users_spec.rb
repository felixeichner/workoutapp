require 'rails_helper'

RSpec.feature "Searching for Users" do
	before do
		@john = User.create!(name: "John Doe", email: "john@mail.com", password: "password")
		@sarah1 = User.create!(name: "Sarah Doe", email: "sarah@mail.com", password: "password")
		@sarah2 = User.create!(name: "Sarah Hays", email: "sarahhays@mail.com", password: "password")
	end

	scenario "as a logged in user with existing name returns all those users" do
		login_as @john
		visit "/"
		fill_in "search_name", with: "Sarah"
		click_button "Search"

		expect(page).to have_link @sarah1.name
		expect(page).to have_link @sarah2.name
		expect(page).not_to have_link @john.name
		expect(current_path).to eq "/"
	end

	scenario "as a logged in user with non-existing name returns all those users" do
		login_as @john
		visit "/"
		fill_in "search_name", with: "Jack"
		click_button "Search"

		expect(page).to have_content "There are no athletes to list"
		expect(page).not_to have_link @sarah1.name
		expect(page).not_to have_link @sarah2.name
		expect(page).not_to have_link @john.name
		expect(current_path).to eq "/"
	end

	scenario "as a non-logged in user returns log in message" do
		visit "/"
		fill_in "search_name", with: "Sarah"
		click_button "Search"

		expect(page).to have_content "Please sign up or log in first"
		expect(page).not_to have_link @sarah1.name
		expect(page).not_to have_link @sarah2.name
		expect(page).not_to have_link @john.name
		expect(current_path).to eq "/dashboards/search"
	end
end