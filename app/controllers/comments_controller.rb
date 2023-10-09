class CommentsController < ApplicationController
  def new
    @author = current_user
    @comment = Comment.new(
      author: @author
    )
    respond_to do |format|
      format.html do
        render :new,
               locals: { comment: @comment }
      end
    end
  end

  def create
    @user = current_user
    @post = @user.posts.find(params[:post_id])
    # new object from params
    @comment = Comment.new(
      post: @post,
      author: @user,
      text: comment_params[:text]
    )
    # respond_to block
    respond_to do |format|
      format.html do
        # If comment saves
        if @comment.save
          # Success message
          flash[:Success] = 'Comment created successfully'
          # redirect to index
          redirect_to user_post_path(@user, @post)
        else
          # Error Message
          flash.now[:Error] = 'Comment not created'
          render :new, locals: { comment: @comment }
          # Render new
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
