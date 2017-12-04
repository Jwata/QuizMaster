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
end

