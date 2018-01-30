require 'rails_helper'

RSpec.feature "Sign up user" do
	scenario "with valid credentials" do
		visit "/"
		click_link "Sign up"

		fill_in "Name", with: "Testname"
		fill_in "Email", with: "test@mail.com"
		fill_in "Password", with: "password"
		fill_in "Password confirmation", with: "password"
		expect {
			click_button "Sign up"
		}.to change(User, :count).by(1)

		expect(page).to have_content "You have signed up successfully."

		user = User.last
		room = user.room
		room_name = "#{user.name}'s chatroom"
		expect(room.name).to eq room_name
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