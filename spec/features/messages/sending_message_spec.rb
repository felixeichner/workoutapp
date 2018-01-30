require 'rails_helper'

RSpec.feature "Sending Message" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		@sarah = User.create!(name: "Sarah", email: "sarah@mail.com", password: "password")
		@david = User.create!(name: "David", email: "david@mail.com", password: "password")
		@mike = User.create!(name: "Mike", email: "mike@mail.com", password: "password")
		login_as @john

		@sarah.friendships.create(friend: @john)
		@david.friendships.create(friend: @john)
	end

	scenario "A user send a message to the chatroom" do
		visit "/users/#{@john.id}/exercises"

		expect(page).to have_content "John's chatroom"

		fill_in "message-field", with: "Hello, this is my first post"
		click_button "Post"

		expect(page).to have_content "Hello, this is my first post"

		within("#followers") do
			expect(page).to have_content @john.name
			expect(page).to have_content @sarah.name
			expect(page).to have_content @david.name
			expect(page).not_to have_content @mike.name
		end
	end
end