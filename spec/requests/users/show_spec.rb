require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  before do
    Rails.cache.clear
    @user = User.new(name: 'diego', photo: '', bio: 'MX dev',
                     email: 'diego@mail.com', password: '123456')
    @user.save
    puts @user.errors.messages unless @user.valid?
  end

  def sign_in(user)
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, { scope: :user })
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end

  # next line render views for last test case
  render_views

  describe 'GET #show' do
    # test if status was correct
    it 'returns a 200 OK status for specific user' do
      sign_in @user
      get :show, params: { id: @user.id }
      expect(response.status).to eq(200)
    end

    # test if correct show template was rendered
    it 'renders the show template' do
      sign_in @user
      get :show, params: { id: @user.id }
      expect(response).to render_template('show')
    end

    # Test if the response body inclue correct plaseholder text
    it 'renders the show template with username, and bio' do
      sign_in @user
      get :show, params: { id: @user.id }
      expect(response.body).to include('diego')
      expect(response.body).to include('MX dev')
    end
  end
end
