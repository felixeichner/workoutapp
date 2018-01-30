require 'rails_helper'

RSpec.feature "Following Users" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		@sarah = User.create!(name: "Sarah", email: "sarah@mail.com", password: "password")
		login_as @john
	end

	scenario "following a user if user is signed in" do
		visit "/"

		expect(page).to have_content @john.name
		expect(page).to have_content @sarah.name

		href= "/friendships?friend_id=#{@john.id}"
		expect(page).not_to have_link("Follow", href: href)

		link = "a[href='/friendships?friend_id=#{@sarah.id}']"
		expect {
			find(link).click
		}.to change(Friendship, :count).by(1)

		href= "/friendships?friend_id=#{@sarah.id}"
		expect(page).not_to have_link("Follow", href: href)		
	end

	scenario "unfollowing a user if user is signed in" do
		@following= @john.friendships.create!(friend: @sarah)
		visit "/users/#{@john.id}/exercises"

		expect(page).to have_link @sarah.name

		expect {
			find("a[href='/friendships/#{@following.id}'][data-method='delete']").click
		}.to change(Friendship, :count).by(-1)

		expect(page).not_to have_link @sarah.name
		href= "/friendships?friend_id=#{@sarah.id}"
		expect(page).not_to have_link("Follow", href: href)
		expect(page).to have_content "You are not following this member anymore"
	end
end