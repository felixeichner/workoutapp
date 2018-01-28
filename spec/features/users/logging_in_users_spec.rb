require 'rails_helper'

RSpec.feature "Log in user" do
	before do
		@john = User.create(name: "John", email: "john@mail.com", password: "password")
	end

	scenario "with valid credentials" do
		visit "/"
		click_link "Log in"

		fill_in "Email", with: @john.email
		fill_in "Password", with: @john.password
		click_button "Log in"

		expect(page).to have_content "Signed in successfully."
		expect(page).to have_content "Signed in as #{@john.name}"
	end

	scenario "with invalid credentials" do
		visit "/"
		click_link "Log in"

		fill_in "Email", with: ""
		fill_in "Password", with: ""
		click_button "Log in"

		expect(page).to have_content "Invalid Email or password."
	end
end