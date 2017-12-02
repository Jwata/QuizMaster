require 'rails_helper'

RSpec.describe 'Questions', type: :system do
  before do
    @question = Question.create!(content: '# This is h1', answer: 'h1')
  end
  scenario 'Allow user to provide formatting or styling for the question content' do
    # Open the new question page
    visit edit_question_path(@question)

    # Check preview
    expect(page).to have_css('h1', text: 'This is h1')

    # TODO: change style
  end
end
