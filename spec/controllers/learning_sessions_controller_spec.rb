require 'rails_helper'

RSpec.describe LearningSessionsController, type: :controller do
  let(:valid_session) { { token: auth_token } }

  let(:auth_token) { user.auth_token.token }

  let(:user) { create(:user) }

  describe 'POST #create' do
    subject { session[:learning_session] }

    let(:learning_session) { double(:learning_session, valid?: true, to_h: learning_session_hash) }

    let(:learning_session_hash) { { dummy: :hash } }

    before do
      allow(LearningSessionManager).to receive(:new_session).and_return(learning_session)
    end

    it 'creates a new learning session' do
      get :create, params: { }, session: valid_session
      expect(subject).to eq learning_session_hash
    end

    context 'when no questions' do
      let(:learning_session) { double(:learning_session, valid?: false, questions: []) }

      before do
        allow(LearningSessionManager).to receive(:new_session).and_return(learning_session)
      end

      it 'redirects to the questions page' do
        get :create, params: { }, session: valid_session
        expect(response).to be_successful
      end
    end

    context 'when failing to create a new learning session' do
      let(:invalid_learning_session) { double(:learning_session, valid?: false) }

      before do
        allow(invalid_learning_session).to receive_message_chain('questions.empty?').and_return(false)
        allow(LearningSessionManager).to receive(:new_session).and_return(invalid_learning_session)
      end

      it 'redirects to the questions page' do
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

        before do
          allow(controller).to receive(:current_question).and_return(Question.new(id: current_question_id))
        end

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

  describe 'GET #destroy' do
    before do
      session[:learning_session] = { dummy: :session }
    end

    it 'redirects to the root path'do
      get :destroy, params: { }, session: valid_session
      expect(response).to redirect_to root_path
      expect(session[:learning_session]).to be_nil
    end
  end

end
