require 'rails_helper'

RSpec.describe 'User', type: :system do
  before(:each) do
    Rails.cache.clear
    Post.destroy_all
    User.destroy_all
    @img = 'icons/icons8-user-60.png'
    @user_one = User.create!(name: 'Mike', photo: @img, bio: 'Teacher from Mexico, living in Japan',
                             password: 'm1234456', email: 'mike@mail.com')
    @user_two = User.create!(name: 'Jerry', photo: @img, bio: 'Student from Japan',
                             password: 'je1234456', email: 'jerry@mail.com')
    @user_three = User.create!(name: 'Monica', photo: @img, bio: 'Student from Brazil',
                               password: 'mo123456', email: 'monica@mail.com')

    # we confirm eails for all users
    @user_one.confirm

    @post_one = Post.create!(author: @user_one, title: 'Jerry post 1', text: 'Jerry post 1 text')
    @post_two = Post.create!(author: @user_one, title: 'Jerry post 2', text: 'Jerry post 2 text')
    @post_three = Post.create!(author: @user_two, title: 'Mike post 1', text: 'Mike post 1 text')
  end

  # lets test user index page first.
  describe 'Index page' do
    # check if we can see the user name of all users
    it "shows all users's username" do
      visit users_path
      fill_in 'user_email', with: 'mike@mail.com'
      fill_in 'user_password', with: 'm1234456'
      # click_on 'Login'
      within('.actions') do
        click_on 'Login'
      end
      sleep(5)
      expect(page).to have_content('Mike')
      expect(page).to have_content('Jerry')
    end

    # check if we can see the user photo of all users
    it "shows all users's photo" do
      visit users_path
      # enter login info
      fill_in 'user_email', with: 'mike@mail.com'
      fill_in 'user_password', with: 'm1234456'
      # click_on 'Login'
      within('.actions') do
        click_on 'Login'
      end
      # assert
      photo_user_one_proccesed = ActionController::Base.helpers.asset_path(@user_one.photo)
      photo_user_two_proccesed = ActionController::Base.helpers.asset_path(@user_two.photo)

      puts ' '
      puts "user one photo --->>> #{@user_one.photo} "
      puts "user two photo --->>> #{@user_two.photo} "
      puts "photo_user_one_proccesed --->>> #{photo_user_one_proccesed} "
      puts "photo_user_two_proccesed --->>> #{photo_user_two_proccesed} "

      expect(page).to have_css("img[src*='#{photo_user_one_proccesed}']")
      expect(page).to have_css("img[src*='#{photo_user_two_proccesed}']")
    end

    # Chekc if we can see the number of posts of each user
    it "shows all users's number of posts" do
      visit users_path
      # enter login info
      fill_in 'user_email', with: 'mike@mail.com'
      fill_in 'user_password', with: 'm1234456'
      # click_on 'Login'
      within('.actions') do
        click_on 'Login'
      end
      # assert

      expect(page).to have_content('2')
      expect(page).to have_content('1')
      expect(page).to have_content('0')
    end

    # Clikc on User should open user show page
    it "click on user should open user#show page and
     show name, bio See more posts button" do
      visit users_path
      # enter login info
      fill_in 'user_email', with: 'mike@mail.com'
      fill_in 'user_password', with: 'm1234456'
      # click_on 'Login'
      within('.actions') { click_on 'Login' }
      # assert
      within('.users') { click_on 'Jerry' }

      expect(page).to have_content('Jerry')
      expect(page).to have_content('Student from Japan')
      expect(page).to have_content('See more posts')

      visit users_path

      within('.users') { click_on 'Mike' }
      expect(page).to have_content('Mike')
      expect(page).to have_content('Teacher from Mexico, living in Japan')
      expect(page).to have_content('See more posts')

      visit users_path
      within('.users') { click_on 'Monica' }
      expect(page).to have_content('Monica')
      expect(page).to have_content('Student from Brazil')
    end
  end
end
