require 'rails_helper'

RSpec.describe 'Post', type: :system do
  before(:each) do
    Like.destroy_all
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
    @img = 'icons/icons8-user-60.png'
    @user = User.create!(name: 'Antonio', photo: @img, bio: 'Teacher from Mexico, living in Japan')

    @follower_one = User.create!(name: 'John', photo: @img, bio: 'Teacher from USA, living in Japan')
    @follower_two = User.create!(name: 'Mike', photo: @img, bio: 'Teacher from USA, living in Japan')
    @follower_tree = User.create!(name: 'Jerry', photo: @img, bio: 'Pitbull from USA, living in Japan')

    @post_one = Post.create!(author: @user, title: 'How to live in Japan', text: 'Live in Japan is very easy')
    @post_two = Post.create!(author: @user, title: 'How to go to the market', text: 'Pick an umbrella and go to the market')

    @like_one = Like.create!(user: @follower_one, post: @post_one)
    @like_two = Like.create!(user: @follower_two, post: @post_one)
    @like_tree = Like.create!(user: @follower_tree, post: @post_one)

    @comment_one = Comment.create!(post: @post_one, author: @follower_one, text: 'I like this post !')
    @comment_two = Comment.create!(post: @post_one, author: @follower_two, text: 'I like this post too')
    @comment_tree = Comment.create!(post: @post_one, author: @follower_tree, text: 'The post is very good')



  end

  describe 'Show Page' do
    it 'should show the post title' do
        visit user_post_path(@user, @post_one)
        
        expect(page).to have_content('Post #1: How to live in Japan')
    end

    it 'should show the who wrote the post' do
        visit user_post_path(@user, @post_one)

        expect(page).to have_content('by Antonio')
    end

    it 'should show how many comments it has' do
        visit user_post_path(@user, @post_one)
        expect(page).to have_content('Comments: 3')
    end

    it 'should show how many likes it has' do
        visit user_post_path(@user, @post_one)
        expect(page).to have_content('Likes: 3')
    end

    it 'should show the post body (post.text)' do
        visit user_post_path(@user, @post_one)
        expect(page).to have_content('Live in Japan is very easy')
    end

    it 'should show the user name of each commentor' do
        visit user_post_path(@user, @post_one)
        expect(page).to have_content('John')
        expect(page).to have_content('Mike')
        expect(page).to have_content('Jerry')
    end

    it 'should show the comment that each user wrote' do
        visit user_post_path(@user, @post_one)
        expect(page).to have_content('I like this post !')
        expect(page).to have_content('I like this post too')
        expect(page).to have_content('The post is very good')
    end
  end
end
