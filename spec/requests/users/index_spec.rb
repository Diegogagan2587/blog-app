require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # clean cache before each test
  before { Rails.cache.clear }

  # fix the last test case
  render_views

  # test if status was correct
  describe 'GET #index' do
    it 'returns a 200 OK status' do
      get :index
      expect(response.status).to eq(200)
    end

    # test if correct template was rendered
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    # Test if the response body inclue correct plaseholder text
    it 'renders the index template with placeholder text' do
      get :index
      expect(response.body).to include('Here is a list of users')
    end
  end
end
