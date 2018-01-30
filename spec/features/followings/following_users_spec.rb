require 'rails_helper'

RSpec.feature "Following Users" do
	before do
		@john = User.create!(name: "John", email: "john@mail.com", password: "password")
		@sarah = User.create!(name: "Sarah", email: "sarah@mail.com", password: "password")
		login_as @john
	end

	scenario "if user is signed in" do
		visit "/"

		expect(page).to have_content @john.name
		expect(page).to have_content @sarah.name

		href= "/friendships?friend_id=#{@john.id}"
		expect(page).not_to have_link("Follow", href: href)

		link = "a[href='/friendships?friend_id=#{@sarah.id}'']"
		find(link).click

		href= "/friendships?friend_id=#{@sarah.id}"
		expect(page).not_to have_link("Follow", href: href)		
	end
end