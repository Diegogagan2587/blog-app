require 'rails_helper'
require 'devise'

RSpec.describe 'User', type: :system do
  before(:each) do
    Rails.cache.clear
    Post.destroy_all
    User.destroy_all
    @img = 'icons/icons8-user-60.png'
    @user_one = User.create!(name: 'Mike', photo: @img, bio: 'Teacher from Mexico, living in Japan',
                             password: 'm1234456', email: 'mike@mail.com')
    @user_two = User.create!(name: 'Jerry', photo: @img, bio: 'Student from Japan',
                             password: 'j1234456', email: 'jerry@mail.com')
    @user_three = User.create!(name: 'Monica', photo: @img, bio: 'Student from Brazil',
                               password: 'mo123456', email: 'monica@mail.com')
    @user_four = User.create!(name: 'John', photo: @img, bio: 'Student from USA',
                              password: 'jo123456', email: 'john@mail.com')

    # we confirm email for fist use since we need to login to create posts
    @user_one.confirm

    @post_one = Post.create!(author: @user_one, title: 'Jerry post 1', text: 'Jerry post 1 text')
    @post_two = Post.create!(author: @user_one, title: 'Jerry post 2', text: 'Jerry post 2 text')
    @post_three = Post.create!(author: @user_two, title: 'Mike post 1', text: 'Mike post 1 text')
    @post_four = Post.create!(author: @user_four, title: 'John post 1', text: 'John post 1 text')
    @post_five = Post.create!(author: @user_four, title: 'John post 2', text: 'John post 2 text')
    @post_six = Post.create!(author: @user_four, title: 'John post 3', text: 'John post 3 text')
    @post_seven = Post.create!(author: @user_four, title: 'John post 4', text: 'John post 4 text')
  end

  # Lets test user show page
  describe 'Show page' do
    it 'Should show user profile picture' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }

      within('.users') { click_on 'Mike' }

      photo_user_one_proccesed = ActionController::Base.helpers.asset_path(@user_one.photo)
      expect(page).to have_css("img[src*='#{photo_user_one_proccesed}']")
    end

    it 'should show the user name: Mike' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on 'Mike' }
      expect(page).to have_content('Mike')
    end

    it 'shoud show the user name: Jerry' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on 'Jerry' }
      expect(page).to have_content('Jerry')
    end

    it 'Should show the nunber of post the user has written: Jerry should show 2 post' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_one.name }
      expect(page).to have_content('2')
    end

    it 'Should show the nunber of post the user has written: Monica should show 0 post' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_three.name }
      expect(page).to have_content('0')
    end

    it 'Should show the nunber of post the user has written: Jerry should show 4 post' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_four.name }

      expect(page).to have_content('4')
    end

    it 'Should show the nunber of post the user has written: Jerry should show 1 post' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_two.name }

      expect(page).to have_content('1')
    end

    it "Should show the Mike user's bio" do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_one.name }

      expect(page).to have_content('Teacher from Mexico, living in Japan')
    end

    it "Should show the Jerry user's bio" do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_two.name }

      expect(page).to have_content('Student from Japan')
    end

    it "Should display the user's first 3 post" do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_four.name }

      expect(page).to have_content('John post 2 text')
      expect(page).to have_content('John post 3 text')
      expect(page).to have_content('John post 4 text')
      expect(page).to_not have_content('John post 1 text')
    end

    it "Should display the button 'See all posts'" do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_one.name }

      expect(page).to have_content('See all posts')
    end

    it 'Should open the clicked Post' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_four.name }

      click_on 'John post 2 text'
      expect(page).to have_content('John post 2 text')
      expect(page).to have_content('Comments:')
      expect(page).to have_content('Likes:')
    end

    it "Should redirect ro user's posts page when click on 'See all posts'" do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user_four.name }

      within('.button') do
        click_on 'See all posts'
      end

      expect(page).to have_content('John post 1 text')
      expect(page).to have_content('John post 2 text')
      expect(page).to have_content('John post 3 text')
      expect(page).to have_content('John post 4 text')
      expect(page).to have_content('Number of posts: 4')
    end
  end
end
