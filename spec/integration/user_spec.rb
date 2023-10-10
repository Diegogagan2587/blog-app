require 'rails_helper'

RSpec.describe 'User', type: :system do
  # lets test user index page first.
  describe 'User index page' do
    before(:each) do
      Rails.cache.clear
      Post.destroy_all
      User.destroy_all
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

    # check if we can see the user photo of all users
    it "shows all users's photo" do
      visit users_path
      puts ' '
      puts "user one photo --->>> #{@user_one.photo} "
      puts "user two photo --->>> #{@user_two.photo} "
      photo_user_one_proccesed = ActionController::Base.helpers.asset_path(@user_one.photo)
      photo_user_two_proccesed = ActionController::Base.helpers.asset_path(@user_two.photo)
      expect(page).to have_css("img[src*='#{photo_user_one_proccesed}']")
      expect(page).to have_css("img[src*='#{photo_user_two_proccesed}']")
    end

  end
end
