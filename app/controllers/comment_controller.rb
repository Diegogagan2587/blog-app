class CommentsController < ActionController
  def new
    @author = current_user
    @comment = Comment.new(
      author: author
    )
    respond_to do |format|
      format.html { 
        render :new ,
        locals: { comment: @comment }
    }
    end
end