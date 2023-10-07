class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
    # we get the index of the current post
    @current_post_number = @user.posts.index(@post) + 1
    # we get count of comments in the post
    @count_comments = @post.comments.count
    @count_likes = @post.likes.count
  end

  def new
    @user = current_user
    @post = Post.new(
      author: @user,
    )
    respond_to do | format |
      format.html {
        render :new,
        locals: { post: @post }
      }
    end
  end
end
