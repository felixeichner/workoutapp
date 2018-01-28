require 'rails_helper'

RSpec.feature "Log out user" do
	before do
		@john = User.create(name: "John", email: "john@mail.com", password: "password")
		login_as @john
	end

	scenario "log out successfully" do
		visit "/"
		click_link "Log out"

		expect(page).to have_content "Signed out successfully."
		expect(page).not_to have_link "Log out"
		expect(page).not_to have_content "Signed in as"
		expect(page).to have_link(href: "/users/sign_up", count: 2)
		expect(page).to have_link(href: "/users/sign_in", count: 2)
	end
end