require 'rails_helper'

RSpec.describe 'User', type: :system do
  # lets test user index page first.
  describe 'User index page' do
    before(:each) { Rails.cache.clear }
    before(:each) do
      @user_one = User.create!(name: 'Tom', photo: @img, bio: 'Teacher from Mexico, living in Japan')
      @user_two = User.create!(name: 'Jerry', photo: @img, bio: 'Student from Japan')
      puts 2
    end

    # check if we can see the user name of all users
    it "shows all users's username" do
      visit users_path

      expect(page).to have_content('Tom')
      expect(page).to have_content('Jerry')
    end
  end
end
