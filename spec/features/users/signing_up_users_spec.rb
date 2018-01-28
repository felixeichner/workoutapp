require 'rails_helper'

RSpec.feature "Sign up user" do
	scenario "with valid credentials" do
		visit "/"
		click_link "Sign up"

		fill_in "Name", with: "Testname"
		fill_in "Email", with: "test@mail.com"
		fill_in "Password", with: "password"
		fill_in "Password confirmation", with: "password"
		click_button "Sign up"

		expect(page).to have_content "You have signed up successfully."
	end

	scenario "with invalid credentials" do
		visit "/"
		click_link "Sign up"

		fill_in "Name", with: ""
		fill_in "Email", with: ""
		fill_in "Password", with: ""
		fill_in "Password confirmation", with: ""
		click_button "Sign up"

		expect(page).to have_content "prohibited this user from being saved"
		expect(page).to have_content "Email can't be blank"
		expect(page).to have_content "Password can't be blank"
		expect(page).to have_content "Name can't be blank"
	end
end