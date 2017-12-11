require 'rails_helper'

RSpec.feature 'Learning Session', type: :system do
  before do
    login_user
    @questions = create_list(:question, 2)
  end

  QUIZ_PATH_PATTERN = %r(^/questions/(?<question_id>\d+)/quiz$)

  scenario 'A user repeats quizes until they answer all quizes correctly' do
    # Start learning session
    visit questions_path
    click_link 'Start Learning Session'

    # First quiz, correct
    expect_to_be_on_quiz_page
    first_id = current_question_id
    fill_in 'Answer', with: correct_answer
    click_button 'Check Answer'
    click_link 'Next Quiz'

    # Second quiz, incorrect
    expect_to_be_on_quiz_page
    second_id = current_question_id
    expect(second_id).not_to eq first_id
    fill_in 'Answer', with: 'incorrect answer'
    click_button 'Check Answer'
    click_link 'Next Quiz'

    # Repeat the second quiz
    expect_to_be_on_quiz_page
    expect(current_question_id).to eq second_id
    fill_in 'Answer', with: correct_answer
    click_button 'Check Answer'
    click_link 'Next Quiz'

    # Complete
    expect(page).to have_current_path(learning_session_path)
    click_link 'Back to Questions'
    expect(page).to have_current_path(questions_path)
  end

  private

    def expect_to_be_on_quiz_page
      expect(page).to have_current_path QUIZ_PATH_PATTERN
    end

    def correct_answer
      current_question.answer
    end

    def current_question
      Question.find(current_question_id)
    end

    def current_question_id
      page.current_path.match(%r(^/questions/(?<question_id>\d+)/quiz$))[:question_id].to_i
    end
end
