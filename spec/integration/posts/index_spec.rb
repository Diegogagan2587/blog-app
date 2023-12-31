require 'rails_helper'

RSpec.describe 'Post', type: :system do
  before(:each) do
    Rails.cache.clear
    Like.destroy_all
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all

    @img = 'icons/icons8-user-60.png'
    @user_one = User.create!(name: 'Mike', photo: @img, bio: 'Teacher from Mexico, living in Japan',
                             password: 'm123456', email: 'mike@email.com')
    # now we need to confirm email of user_one to be able to login and run test adn create posts
    @user_one.confirm
    @user_two = User.create!(name: 'John', photo: @img, bio: 'Teacher from USA, living in Japan',
                             password: 'j123456', email: 'john@email.com')
    @user_two.confirm

    @post_one = Post.create!(author: @user_one, title: 'Mike post 1', text: 'Mike post 1 text')
    @post_two = Post.create!(author: @user_one, title: 'Mike post 2', text: 'Mike post 2 text')
    @post_three = Post.create!(author: @user_one, title: 'Mike post 3', text: 'Mike post 3 text')
    @post_four = Post.create!(author: @user_one, title: 'Mike post 4', text: 'Mike post 4 text')
    @post_five = Post.create!(author: @user_one, title: 'Mike post 5', text: 'Mike post 5 text')
    @post_six = Post.create!(author: @user_two, title: 'John post 1', text: 'John post 1 text')

    @comment_one = Comment.create!(post: @post_one, author: @user_one, text: 'Mike post 1 comment 1')

    @like_one = Like.create!(user: @user_one, post: @post_one)
  end

  describe 'Index page' do
    it "shoud show the user's profile picture" do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on 'Mike' }

      photo_user_one_proccesed = ActionController::Base.helpers.asset_path(@user_one.photo)
      expect(page).to have_css("img[src*='#{photo_user_one_proccesed}']")
    end

    it "shoud show the user's name" do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on 'Mike' }
      expect(page).to have_content('Mike')
    end

    it 'shold show the number of posts the user has written' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password

      within('.new_user') { click_on 'Login' }

      within('.users') { click_on 'Mike' }

      expect(page).to have_content('Number of posts: 5')
    end

    it 'Should show the title of the post' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on 'Mike' }

      within('.btn-user-posts') { click_on 'See more posts' }

      expect(page).to have_content('Post #1 Mike post 1')
      expect(page).to have_content('Post #2 Mike post 2')
      expect(page).to have_content('Post #3 Mike post 3')
      expect(page).to have_content('Post #4 Mike post 4')
      expect(page).to have_content('Post #5 Mike post 5')
    end

    it "should show some of the post's body(text)" do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on 'Mike' }
      within('.btn-user-posts') { click_on 'See more posts' }

      visit user_posts_path(@user_one)

      expect(page).to have_content('Mike post 1 text')
    end

    it 'should show the first comment of the post' do
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on 'Mike' }
      within('.btn-user-posts') { click_on 'See more posts' }
      expect(page).to have_content('Mike post 1 comment 1')
    end

    it 'should show the number of comments the post has' do
      # we login with any user to be able to see the post
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      # we naviate to the post#index page
      within('.users') { click_on 'Mike' }
      within('.btn-user-posts') { click_on 'See more posts' }
      # we test the number of comments
      expect(page).to have_content('Comments: 1')
      expect(page).to have_content('Comments: 0')
    end

    it 'should show the number of likes the post has' do
      # we login with any user to be able to see the post
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      # we naviate to the post#index page
      within('.users') { click_on 'Mike' }
      within('.btn-user-posts') { click_on 'See more posts' }
      # we test the number of likes
      visit user_posts_path(@user_one)
      expect(page).to have_content('Likes: 1')
      expect(page).to have_content('Likes: 0')
    end

    it 'should show a section for pagination if there are more posts than fit on the view' do
      # we create aditional user to have more than 5 test and reder pagiantion nav
      @post_seven = Post.create!(author: @user_one, title: 'Mike post 6', text: 'Mike post 6 text')

      visit user_posts_path(@user_one)

      # then we test the pagination nav
      expect(page).to have_css('.pagination')
      expect(page).to have_content('Next')
      expect(page).to have_content('Last')
    end

    it "should redirect to a post's show page when clicking on the post's title" do
      # we login with any user to be able to see the post
      visit users_path
      fill_in 'user_email', with: @user_one.email
      fill_in 'user_password', with: @user_one.password
      within('.new_user') { click_on 'Login' }
      # we naviate to the posts#index page
      within('.users') { click_on 'Mike' }
      within('.btn-user-posts') { click_on 'See more posts' }
      # we navigate to the post#show page
      within('.post-list') { click_on 'Mike post 1' }

      # we test the the page is redirected to the post#show page
      expect(page).to have_current_path(user_post_path(@user_one, @post_one))
    end
  end
end
