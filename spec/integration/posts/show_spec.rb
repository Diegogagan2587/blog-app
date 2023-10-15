require 'rails_helper'

RSpec.describe 'Post', type: :system do
  before(:each) do
    Like.destroy_all
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
    @img = 'icons/icons8-user-60.png'
    @user = User.create!(name: 'Antonio', photo: @img, bio: 'Teacher from Mexico, living in Japan',
                         password: 'a123456', email: 'antonio@email.com')

    @follower_one = User.create!(name: 'John', photo: @img, bio: 'Teacher from USA, living in Japan',
                                 password: 'j123456', email: 'john@email.com')
    @follower_two = User.create!(name: 'Mike', photo: @img, bio: 'Teacher from USA, living in Japan',
                                 password: 'm123456', email: 'mike@email.com')
    @follower_tree = User.create!(name: 'Jerry', photo: @img, bio: 'Pitbull from USA, living in Japan',
                                  password: 'j123456', email: 'jerry@mail.com')

    @post_one = Post.create!(author: @user, title: 'How to live in Japan', text: 'Live in Japan is very easy')
    @post_two = Post.create!(author: @user, title: 'How to go to the market',
                             text: 'Pick an umbrella and go to the market')

    @like_one = Like.create!(user: @follower_one, post: @post_one)
    @like_two = Like.create!(user: @follower_two, post: @post_one)
    @like_tree = Like.create!(user: @follower_tree, post: @post_one)

    @comment_one = Comment.create!(post: @post_one, author: @follower_one, text: 'I like this post !')
    @comment_two = Comment.create!(post: @post_one, author: @follower_two, text: 'I like this post too')
    @comment_tree = Comment.create!(post: @post_one, author: @follower_tree, text: 'The post is very good')

    # since we require user confirmation to be able to login, we need to confirm the user
    @user.confirm
    @follower_one.confirm
    @follower_two.confirm
    @follower_tree.confirm
  end

  describe 'Show Page' do
    it 'should show the post title' do
      # we need to login first
      visit users_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      within('.new_user') { click_on 'Login' }
      # then we can visit the post show page
      within('.users') { click_on @user.name }
      within('.posts') { click_on @post_one.title }
      # now we can test if the post title is shown

      expect(page).to have_content('Post #2: How to live in Japan')
    end

    it 'should show the who wrote the post' do
      # first we authenticate the user
      visit users_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      within('.new_user') { click_on 'Login' }
      # then we can visit the post show page
      within('.users') { click_on @user.name }
      within('.btn-user-posts') { click_on 'See more posts' }

      within('.post-list') { click_on @post_one.title }

      expect(page).to have_content('by Antonio')
    end

    it 'should show how many comments it has' do
      visit users_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user.name }
      within('.btn-user-posts') { click_on 'See more posts' }
      within('.post-list') { click_on @post_one.title }

      expect(page).to have_content('Comments: 3')
    end

    it 'should show how many likes it has' do
      visit users_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user.name }
      within('.btn-user-posts') { click_on 'See more posts' }
      within('.post-list') { click_on @post_one.title }
      expect(page).to have_content('Likes: 3')
    end

    it 'should show the post body (post.text)' do
      visit users_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user.name }
      within('.btn-user-posts') { click_on 'See more posts' }
      within('.post-list') { click_on @post_one.title }
      expect(page).to have_content('Live in Japan is very easy')
    end

    it 'should show the user name of each commentor' do
      visit users_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user.name }
      within('.btn-user-posts') { click_on 'See more posts' }
      within('.post-list') { click_on @post_one.title }
      expect(page).to have_content('John')
      expect(page).to have_content('Mike')
      expect(page).to have_content('Jerry')
    end

    it 'should show the comment that each user wrote' do
      visit users_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      within('.new_user') { click_on 'Login' }
      within('.users') { click_on @user.name }
      within('.btn-user-posts') { click_on 'See more posts' }
      within('.post-list') { click_on @post_one.title }
      expect(page).to have_content('I like this post !')
      expect(page).to have_content('I like this post too')
      expect(page).to have_content('The post is very good')
    end
  end
end
