require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
  # clean cache before each test
  before(:each) do
    Rails.cache.clear
    @user_one = User.create!(name: 'Tom', photo: @img, bio: 'Teacher from Mexico, living in Japan',
                             email: 'tom@mail.com', password: '123456')
    @user_two = User.create!(name: 'Jerry', photo: @img, bio: 'Student from Japan', email: 'jerry@mail.com',
                             password: '123456')
  end
  # fix the last test case
  render_views

  # test if status was correct
  describe 'GET #index' do
    it 'returns a 200 OK status' do
      # we sing any user to get access to the index
      sign_in @user_one
      # then we test the status
      get :index
      expect(response.status).to eq(200)
    end

    # test if correct template was rendered
    it 'renders the index template' do
      # we sing any user to get access to the index
      sign_in @user_one
      # then we test the template
      get :index
      expect(response).to render_template('index')
    end

    # Test if the response body inclue correct plaseholder text
    it 'renders the index template with users Tom and Jerry' do
      # we sing any user to get access to the index
      sign_in @user_one
      # then we test the response body
      get :index
      expect(response.body).to include('Tom')
      expect(response.body).to include('Jerry')
    end
  end
end
