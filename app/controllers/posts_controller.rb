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

  def create
    # new object from params
    @user = current_user
    #post_params is intended to help to avoid mass assignment
    @post = Post.new(
      author: @user,
      title: post_params[:title],
      text: post_params[:text],
    )
    # respond_to block
    respond_to do | format | 
      format.html do 
        if @post.save
          # Success message
          flash[:Success] = "Post created successfully"
          # redirect to index
          redirect_to user_posts_path(@user)
        else
          # Error Message
          flash.now[:Error] = "Post not created"
          # Render new
          render :new, locals: { post: @post }
        end
      end
    end
  end

  private
   def post_params
    params.require(:post).permit(:title, :text)
   end
end
