require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before { Rails.cache.clear }
  before do
    @user = User.new(name: 'diego', photo: '', bio: 'MX dev')
    @user.save
  end

  # next line render views for last test case
  render_views

  describe 'GET #show' do
    # test if status was correct
    it 'returns a 200 OK status for specific user' do
      get :show, params: { id: @user.id }
      expect(response.status).to eq(200)
    end

    # test if correct show template was rendered
    it 'renders the show template' do
      get :show, params: { id: @user.id }
      expect(response).to render_template('show')
    end

    # Test if the response body inclue correct plaseholder text
    it 'renders the show template with username, and bio' do
      get :show, params: { id: @user.id }
      expect(response.body).to include('diego')
      expect(response.body).to include('MX dev')
    end
  end
end