module PostsHelper
  def show_likes_button
    if @is_liked
      button_to "Don't Like it", delete_like_user_post_path(user_id: @user.id, id: @post.id), method: :delete, class: 'button', remote: true
                                                                                 
    else
      button_to 'Like it', add_like_user_post_path(user_id: @user.id, id: @post.id), method: :post, class: 'button', remote: true

    end
  end
end
