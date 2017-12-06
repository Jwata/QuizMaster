require 'rails_helper'

RSpec.describe 'Quiz mode', type: :system do
  before do
    login_user
    @question = Question.create!(content: "# #{content}", answer: correct_answer)
  end

  let(:content) { 'Q: How many vowels are there in the English alphabet?' }
  let(:correct_answer) { 5 }
  let(:incorrect_answer) { 6 }
  let(:correct_answer_in_word) { 'five' }
  let(:incorrect_answer_in_word) { 'six' }

  scenario 'Show a question and user should be able to submit an answer' do
    visit quiz_question_path(@question)

    expect(page).to have_css('h1', text: content)

    fill_in 'Answer', with: correct_answer

    click_button 'Check Answer'

    expect(page).to have_content(correct_answer)
  end

  scenario 'App should be able to check and handle cases wherein answer is correct or incorrect' do
    visit quiz_question_path(@question)

    # Incorrect answer
    fill_in 'Answer', with: incorrect_answer

    click_button 'Check Answer'

    expect(page).to have_content('Incorrect Answer!')

    # Try Again
    click_link 'Try Again'

    # Correct answer
    fill_in 'Answer', with: correct_answer

    click_button 'Check Answer'

    expect(page).to have_content('Correct Answer!')
  end

  scenario 'In cases wherein the answer is/contains a number, it should recognise the number as words' do
    visit quiz_question_path(@question)

    # Incorrect answer
    fill_in 'Answer', with: incorrect_answer_in_word

    click_button 'Check Answer'

    expect(page).to have_content('Incorrect Answer!')

    # Try Again
    click_link 'Try Again'

    # Correct answer
    fill_in 'Answer', with: correct_answer_in_word

    click_button 'Check Answer'

    expect(page).to have_content('Correct Answer!')
  end
end
