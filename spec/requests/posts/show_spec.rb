require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    before { Rails.cache.clear }
    before {
        @user = User.new(name: 'diego', photo: '@', bio: 'bio')
        @user.save
    }
    #next line will allow to check if the placeholder text is present
    render_views

    #test if status was correct
    it 'returns a 200 OK statud' do
      get :index, params: { user_id: @user.id}
      expect(response.status).to eq(200)
    end
end