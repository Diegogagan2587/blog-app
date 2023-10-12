require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before { Rails.cache.clear }
  before do
    @user = User.new(name: 'diego', photo: '', bio: 'bio')
    @user.save
  end
  # next line is to fix the last test case
  render_views

  # test if status was correct
  describe 'GET #index' do
    it 'returns a 200 OK status' do
      get :index, params: { user_id: @user.id }
      expect(response.status).to eq(200)
    end

    # test if correct template was rendered
    it 'renders the index template' do
      get :index, params: { user_id: @user.id }
      expect(response).to render_template('index')
    end

    # Test if the response body inclue correct plaseholder text
    it 'renders the index template with right placeholders' do
      get :index, params: { user_id: @user.id }
      expect(response.body).to include('diego')
      expect(response.body).to include('Number of posts')
      expect(response.body).to include('New post')
      expect(response.body).to include('Back to profile')
    end
  end
end