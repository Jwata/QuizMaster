require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:valid_session) { { token: auth_token } }

  let(:auth_token) { user.auth_token.token }

  let(:user) { create(:user) }

  describe 'GET #index' do
    it 'redirects to the questions index page' do
      get :index, params: { }, session: valid_session
      expect(response).to redirect_to(questions_url)
    end
  end

end
