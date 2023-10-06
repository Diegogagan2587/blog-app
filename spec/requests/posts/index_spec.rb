require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before { Rails.cache.clear }
  before { 
    @user = User.new(name: 'diego', photo: '#', bio: 'bio')
    @user.save
}
  render_views

  #test if status was correct
  describe 'GET #index' do
    it 'returns a 200 OK status' do
        get :index, params: { user_id: @user.id }
        puts "----->>>response: #{response.status}"
        expect(response.status).to eq(200)
    end

    #test if correct template was rendered
    it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
    end

    #Test if the response body inclue correct plaseholder text
    it 'renders the index template with placeholder text' do
        get :index
        expect(response.body).to include('This will show up information about all posts for a given user')
    end
  end
end