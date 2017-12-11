require 'rails_helper'

RSpec.describe 'questions/quiz', type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :content => 'MyString',
      :answer => 'MyString'
    ))
  end

  it 'renders the quiz form' do
    render template: 'questions/quiz'

    assert_select 'form[action=?][method=?]', quiz_question_path(@question), 'post' do
      assert_select 'input[name=?]', 'quiz[answer]'
    end
  end

  context 'when completed' do
    helper_method :current_learning_session

    before do
      flash[:quiz_answer] = true
      allow(view).to receive(:current_learning_session).and_return(learning_session)
    end

    context 'when no learning session' do
      let(:learning_session) { nil }

      it 'shows next actions' do
        render template: 'questions/quiz'
        expect(rendered).to match(/Try Again/)
        expect(rendered).to match(/Show Answer/)
        expect(rendered).to match(/Back to List/)
      end
    end

    context 'during a learning session' do
      let(:learning_session) { double(:learning_session) }

      it 'shows next quiz button' do
        render template: 'questions/quiz'
        expect(rendered).to match(/Next Quiz/)
      end
    end
  end
end
