require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Question. As you add validations to Question, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { content: "What's the best mountain in Japan?", answer: 'Mount Fuji' }
  }

  let(:invalid_attributes) {
    { content: nil, answer: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuestionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Question.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end

    it 'assigns questions' do
      question = Question.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:questions)).to eq [question]
    end
  end

  describe 'GET #show' do
    let(:assigned_question) { assigns(:question) }

    it 'returns a success response' do
      question = Question.create! valid_attributes
      get :show, params: {id: question.to_param}, session: valid_session
      expect(response).to be_successful
    end

    it 'assigns question' do
      question = Question.create! valid_attributes
      get :show, params: {id: question.to_param}, session: valid_session
      expect(assigned_question).to eq question
    end
  end

  describe 'GET #new' do
    let(:assigned_question) { assigns(:question) }

    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end

    it 'assigns question' do
      get :new, params: {}, session: valid_session
      expect(assigned_question.content).to be_blank
      expect(assigned_question.answer).to be_blank
    end
  end

  describe 'GET #edit' do
    let(:assigned_question) { assigns(:question) }

    it 'returns a success response' do
      question = Question.create! valid_attributes
      get :edit, params: {id: question.to_param}, session: valid_session
      expect(response).to be_successful
    end

    it 'assigns question' do
      question = Question.create! valid_attributes
      get :edit, params: {id: question.to_param}, session: valid_session
      expect(assigned_question).to eq question
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Question' do
        expect {
          post :create, params: {question: valid_attributes}, session: valid_session
        }.to change(Question, :count).by(1)
      end

      it 'redirects to the created question' do
        post :create, params: {question: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Question.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        post :create, params: {question: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { content: "What's the best mountain in the world?", answer: 'Mount Everest' }
      }

      it 'updates the requested question' do
        question = Question.create! valid_attributes
        put :update, params: {id: question.to_param, question: new_attributes}, session: valid_session
        question.reload
        expect(question.content).to eq new_attributes[:content]
        expect(question.answer.to_s).to eq new_attributes[:answer]
      end

      it 'redirects to the question' do
        question = Question.create! valid_attributes
        put :update, params: {id: question.to_param, question: valid_attributes}, session: valid_session
        expect(response).to redirect_to(question)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        question = Question.create! valid_attributes
        put :update, params: {id: question.to_param, question: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested question' do
      question = Question.create! valid_attributes
      expect {
        delete :destroy, params: {id: question.to_param}, session: valid_session
      }.to change(Question, :count).by(-1)
    end

    it 'redirects to the questions list' do
      question = Question.create! valid_attributes
      delete :destroy, params: {id: question.to_param}, session: valid_session
      expect(response).to redirect_to(questions_url)
    end
  end

  describe 'GET #quiz' do
    let(:assigned_question) { assigns(:question) }

    it 'returns a success response' do
      question = Question.create! valid_attributes
      get :quiz, params: {id: question.to_param}, session: valid_session
      expect(response).to be_successful
    end

    it 'assigns question' do
      question = Question.create! valid_attributes
      get :quiz, params: {id: question.to_param}, session: valid_session
      expect(assigned_question).to eq question
    end
  end

  describe 'POST #check_answer' do
    let(:quiz_answer) { question.answer }
    let(:question) { Question.create! valid_attributes }

    it 'redirects to the quiz' do
      post :check_answer, params: {id: question.to_param, quiz: { answer: quiz_answer }}, session: valid_session
      expect(response).to redirect_to(quiz_question_path)
    end
  end

end
