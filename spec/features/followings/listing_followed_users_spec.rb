require 'rails_helper'

RSpec.feature "Listing followed Users" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		@sarah = User.create!(name: "Sarah", email: "sarah@mail.com", password: "password")
		@marc = User.create!(name: "Marc", email: "marc@mail.com", password: "password")
		@david = User.create!(name: "David", email: "david@mail.com", password: "password")
		login_as @john
		@following1 = @john.friendships.create!(friend_id: @sarah.id)
		@following2 = @john.friendships.create!(friend_id: @marc.id)
		@following3 = @sarah.friendships.create!(friend_id: @david.id)
		@following4 = @sarah.friendships.create!(friend_id: @john.id)
	end

	scenario "as a logged in user on their lounge page" do
		visit "/users/#{@john.id}/exercises"

		expect(page).to have_content "My Friends"
		expect(page).to have_link "Sarah"
		expect(page).to have_link "Marc"
		expect(page).not_to have_link("John", href: "/users/#{@john.id}")
		expect(page).not_to have_link "David"
		expect(page).to have_link("Unfollow", href: "/friendships/#{@following1.id}")
		expect(page).to have_link("Unfollow", href: "/friendships/#{@following2.id}")
		expect(page).not_to have_link("Unfollow", href: "/friendships/#{@following3.id}")
		expect(page).not_to have_link("Unfollow", href: "/friendships/#{@following4.id}")
	end

	scenario "as a logged in user on someone else lounge page" do
		visit "/users/#{@john.id}/exercises"
		find("a[href='/users/#{@sarah.id}/exercises']").click

		expect(page).to have_content "My Friends"
		expect(page).not_to have_link "Sarah"
		expect(page).not_to have_link "Marc"
		expect(page).to have_link "John"
		expect(page).to have_link "David"
		expect(page).not_to have_link("Unfollow", href: "/friendships/#{@following1.id}")
		expect(page).not_to have_link("Unfollow", href: "/friendships/#{@following2.id}")
		expect(page).not_to have_link("Unfollow", href: "/friendships/#{@following3.id}")
		expect(page).not_to have_link("Unfollow", href: "/friendships/#{@following4.id}")
	end

end