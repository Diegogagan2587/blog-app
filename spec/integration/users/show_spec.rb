require 'rails_helper'

RSpec.describe 'User', type: :system do
  before(:each) do
    Rails.cache.clear
    Post.destroy_all
    User.destroy_all
    @img = 'icons/icons8-user-60.png'
    @user_one = User.create!(name: 'Mike', photo: @img, bio: 'Teacher from Mexico, living in Japan')
    @user_two = User.create!(name: 'Jerry', photo: @img, bio: 'Student from Japan')
    @user_three = User.create!(name: 'Monica', photo: @img, bio: 'Student from Brazil')
    @user_four = User.create!(name: 'John', photo: @img, bio: 'Student from USA')

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
      visit user_path(@user_one)
      photo_user_one_proccesed = ActionController::Base.helpers.asset_path(@user_one.photo)
      expect(page).to have_css("img[src*='#{photo_user_one_proccesed}']")
    end

    it 'should show the user name: Mike' do
      visit user_path(@user_one)
      expect(page).to have_content('Mike')
    end

    it 'shoud show the user name: Jerry' do
      visit user_path(@user_two)
      expect(page).to have_content('Jerry')
    end

    it 'Should show the nunber of post the user has written: Jerry should show 2 post' do
      visit user_path(@user_one)
      expect(page).to have_content('2')
    end

    it 'Should show the nunber of post the user has written: Jerry should show 0 post' do
      visit user_path(@user_three)
      expect(page).to have_content('0')
    end

    it 'Should show the nunber of post the user has written: Jerry should show 4 post' do
      visit user_path(@user_four)
      expect(page).to have_content('4')
    end

    it 'Should show the nunber of post the user has written: Jerry should show 1 post' do
      visit user_path(@user_two)
      expect(page).to have_content('1')
    end

    it "Should show the Mike user's bio" do
      visit user_path(@user_one)
      expect(page).to have_content('Teacher from Mexico, living in Japan')
    end

    it "Should show the Jerry user's bio" do
      visit user_path(@user_two)
      expect(page).to have_content('Student from Japan')
    end

    it "Should display the user's first 3 post" do
      visit user_path(@user_four)
      expect(page).to have_content('John post 2 text')
      expect(page).to have_content('John post 3 text')
      expect(page).to have_content('John post 4 text')
      expect(page).to_not have_content('John post 1 text')
    end

    it "Should display the button 'See all posts'" do
        visit user_path(@user_one)
        expect(page).to have_content('See all posts')
    end

    it "Should redirect ro user's posts page when click on 'See all posts'" do
        visit user_path(@user_four)
        
        within(".button") do
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
