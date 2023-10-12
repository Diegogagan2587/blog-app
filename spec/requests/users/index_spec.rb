require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # clean cache before each test
  before(:each) do
    Rails.cache.clear
    @user_one = User.create!(name: 'Tom', photo: @img, bio: 'Teacher from Mexico, living in Japan')
    @user_two = User.create!(name: 'Jerry', photo: @img, bio: 'Student from Japan')
  end
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
    it 'renders the index template with users Tom and Jerry' do
      get :index
      expect(response.body).to include('Tom')
      expect(response.body).to include('Jerry')
    end
  end
end