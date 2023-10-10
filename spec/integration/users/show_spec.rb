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

    
  end
end
