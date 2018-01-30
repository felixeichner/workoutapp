require 'rails_helper'

RSpec.feature "Listing followed Users" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		@sarah = User.create!(name: "Sarah", email: "sarah@mail.com", password: "password")
		@marc = User.create!(name: "Marc", email: "marc@mail.com", password: "password")
		@david = User.create!(name: "David", email: "david@mail.com", password: "password")
		login_as @john
		@john.friendships.create!(friend_id: @sarah.id)
		@john.friendships.create!(friend_id: @marc.id)
	end

	scenario "as a logged in user on their lounge page" do
		visit "/users/#{@john.id}/exercises"

		expect(page).to have_content "My Friends"
		expect(page).to have_link "Sarah"
		expect(page).to have_link "Marc"
		expect(page).not_to have_link "John"
		expect(page).not_to have_link "David"
		expect(page).to have_link("Unfollow", href: "/friendships?friend_id=#{@sarah.id}")
		expect(page).to have_link("Unfollow", href: "/friendships?friend_id=#{@marc.id}")
		expect(page).not_to have_link("Unfollow", href: "/friendships?friend_id=#{@john.id}")
		expect(page).not_to have_link("Unfollow", href: "/friendships?friend_id=#{@david.id}")
	end
end