require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before do
    Rails.cache.clear
    @user = User.new(name: 'diego', photo: '', bio: 'bio', email: 'diego@mail.com', password: '123456')
    @post = Post.new(author: @user, text: 'text', title: 'title')
    @post.save
    @user.save
    puts @user.errors.messages unless @user.valid?
    puts @post.errors.messages unless @post.valid?
  end
  # next line will allow to check if the placeholder text is present
  render_views

  describe 'GET #show' do
    # test if status was correct
    it 'returns a 200 OK status' do
      # next line simulate get: /users/@user.id/posts/post.id
      get :show, params: { user_id: @user.id, id: @post.id }
      expect(response.status).to eq(200)
    end

    # test if correct template was rendered
    it 'renders the show template' do
      get :show, params: { user_id: @user.id, id: @post.id }
      expect(response).to render_template('show')
    end

    # Test if the response body inclue correct plaseholder text
    it 'renders the show template with placeholder text' do
      get :show, params: { user_id: @user.id, id: @post.id }
      expect(response.body).to include('Post')
      expect(response.body).to include('by diego')
      expect(response.body).to include('Comments')
      expect(response.body).to include('Likes')
    end
  end
end
