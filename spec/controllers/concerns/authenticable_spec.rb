require 'rails_helper'

RSpec.describe Authenticable, type: :controller do
  controller(ApplicationController) do
    include Authenticable

    def index
      head :ok
    end
  end

  before do
    routes.draw { get 'index' => 'anonymous#index' }
  end

  let(:auth_token) { user.auth_token.token }
  let(:user) { create(:user) }

  context 'when the request fails to authenticate' do
    it 'returns 401' do
      get :index, params: { token: 'invalid_token' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the request has a valid token param' do
    it 'redirects to the same path without the token param' do
      get :index, params: { token: auth_token }
      expect(response).to redirect_to(request.path)
    end
  end

  context 'when the request contains a token inside the session' do
    it "passes authentication" do
      get :index, params: {}, session: { token: auth_token }
      expect(response).to be_successful
    end
  end
end
