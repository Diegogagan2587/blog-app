require 'rails_helper'
require 'devise'
require 'warden'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  def sign_in(user)
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, { scope: :user })
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end

  before :each do
    Rails.cache.clear
    User.destroy_all
    Post.destroy_all
    @user = User.create(name: 'diego', photo: '', bio: 'bio', email: 'diego@mail.com', password: '123456')
    @post = Post.create(author: @user, title: 'title', text: 'text')
    @user.confirm
    sign_in @user
    puts @user.errors.messages unless @user.valid?
  end
  # next line is to fix the last test case
  render_views

  # test if status was correct
  describe 'GET #index' do
    it 'returns a 200 OK status' do
      sign_in @user
      get :index, params: { user_id: @user.id }
      expect(response.status).to eq(200)
    end

    # test if correct template was rendered
    it 'renders the index template' do
      sign_in @user
      get :index, params: { user_id: @user.id }
      expect(response).to render_template('index')
    end

    # Test if the response body includes correct placeholder text
    it 'renders the index template with right placeholders' do
      sign_in @user
      get :index, params: { user_id: @user.id }
      expect(response.body).to include('diego')
      expect(response.body).to include('Number of posts:')
      expect(response.body).to include('New post')
      expect(response.body).to include('Back to profile')
    end
  end
end
