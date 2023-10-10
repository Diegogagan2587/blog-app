require 'rails_helper'

RSpec.describe 'User', type: :system do
  # lets test user index page first.
  describe 'User index page' do
    before(:each) do
      Rails.cache.clear
      @img = 'icons/icons8-user-60.png'
      @user_one = User.create!(name: 'Mike', photo: @img, bio: 'Teacher from Mexico, living in Japan')
      @user_two = User.create!(name: 'Jerry', photo: @img, bio: 'Student from Japan')
    end

    # check if we can see the user name of all users
    it "shows all users's username" do
      visit users_path

      expect(page).to have_content('Mike')
      expect(page).to have_content('Jerry')
    end

   
  end
end
