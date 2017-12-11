require 'rails_helper'

RSpec.describe LearningSessionsController, type: :controller do
  let(:valid_session) { { token: auth_token } }

  let(:auth_token) { user.auth_token.token }

  let(:user) { create(:user) }

  describe 'POST #create' do
    subject(:learning_session) { session[:learning_session] }

    before do
      allow(Question).to receive_message_chain('all.pluck').and_return([1])
    end

    it 'creates a new learning session' do
      get :create, params: { }, session: valid_session
      expect(learning_session).to include(:questions, :current_index)
    end

    context 'when failing to create a new learning session' do
      before do
        allow(LearningSession).to receive(:new).and_return(invalid_learning_session)
      end

      let(:invalid_learning_session) { double(:learning_session, valid?: false) }

      it 'redirects to thequestions page' do
        get :create, params: { }, session: valid_session
        expect(response).to redirect_to(questions_path)
      end
    end
  end

  describe 'GET #show' do
    before do
      allow(controller).to receive(:current_learning_session)
        .and_return(current_learning_session)
    end

    context "when the learning session doesn't exist" do
      let(:current_learning_session) { nil }

      it 'redirects to the root path'do
        get :show, params: { }, session: valid_session
        expect(response).to redirect_to root_path
      end
    end

    context 'when the learning session exists' do
      context "when the learning session isn't completed" do
        let(:current_learning_session) do
          double(:learning_session, completed?: false, current_question: current_question)
        end
        let(:current_question) { double(:current_questoion, id: current_question_id) }
        let(:current_question_id) { 1 }

        it 'redirects to the current quiz page'do
          get :show, params: { }, session: valid_session
          expect(response).to redirect_to quiz_question_path(id: current_question_id)
        end
      end

      context "when the learning session has been completed" do
        let(:current_learning_session) do
          double(:learning_session, completed?: true, current_question: nil)
        end

        it 'shows the completion page'do
          expect(controller).to receive(:render).with(:completed).and_call_original
          get :show, params: { }, session: valid_session
          expect(response).to be_successful
        end
      end
    end
  end

end
