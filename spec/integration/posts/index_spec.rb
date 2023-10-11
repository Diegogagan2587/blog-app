require 'rails_helper'

RSpec.describe 'Post', type: :system do
    before(:each) do
        Post.destroy_all
        User.destroy_all
        @img = 'icons/icons8-user-60.png'
        @user_one = User.create!(name: 'Mike', photo: @img, bio: 'Teacher from Mexico, living in Japan')
        @post_one = Post.create!(author: @user_one, title: 'Mike post 1', text: 'Mike post 1 text')
        @post_two = Post.create!(author: @user_one, title: 'Mike post 2', text: 'Mike post 2 text')
        @post_three = Post.create!(author: @user_one, title: 'Mike post 3', text: 'Mike post 3 text')
        @post_four = Post.create!(author: @user_one, title: 'Mike post 4', text: 'Mike post 4 text')
        @post_five = Post.create!(author: @user_one, title: 'Mike post 5', text: 'Mike post 5 text')

    end

    describe "Index page" do
        it "shoud show the user's profile picture" do
            visit user_posts_path(@user_one)
            
            photo_user_one_proccesed = ActionController::Base.helpers.asset_path(@user_one.photo)
            expect(page).to have_css("img[src*='#{photo_user_one_proccesed}']")
        end

        it "shoud show the user's name" do
            visit user_posts_path(@user_one)
            expect(page).to have_content('Mike')
        end

        it "shold show the number of posts the user has written" do
            visit user_posts_path(@user_one)
            expect(page).to have_content('Number of posts: 5')
        end

        it "Should show the title of the post" do
            visit user_posts_path(@user_one)
            
            expect(page).to have_content('Post #1 Mike post 1')
            expect(page).to have_content('Post #2 Mike post 2')
            expect(page).to have_content('Post #3 Mike post 3')
            expect(page).to have_content('Post #4 Mike post 4')
            expect(page).to have_content('Post #5 Mike post 5')
        end
    end
end