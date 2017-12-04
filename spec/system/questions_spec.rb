require 'rails_helper'

RSpec.describe 'Questions', type: :system do
  before do
    @question = Question.create!(content: content, answer: answer)
  end

  let(:content) { "What's the highest mountaion in Japan?" }
  let(:answer) { 'Mount Fuji' }
  let(:new_content) { "What's the highest mountaion in the world?" }
  let(:new_answer) { 'Mount Everest' }

  feature 'CRUD operations for questions' do
    scenario 'Allow user to create a question' do
      # Open the new question page
      visit new_question_path

      # Fill in content and answer
      fill_in_editor_field new_content
      fill_in 'Answer', with: new_answer

      # Submit
      click_button 'Save'

      # Check if the content and answer were saved properly
      expect(page).to have_content(new_content)
      expect(page).to have_content(new_answer)
    end

    scenario 'Allow user to show a question' do
      # Open the question page
      visit question_path(@question)

      expect(page).to have_content(content)
      expect(page).to have_content(answer)
    end

    scenario 'Allow user to edit a question' do
      # Open the edit question page
      visit edit_question_path(@question)

      # Change content and answer
      fill_in_editor_field new_content
      fill_in 'Answer', with: new_answer

      # Submit
      click_button 'Save'

      # Check if the content and answer were updated properly
      expect(page).to have_content(new_content)
      expect(page).to have_content(new_answer)
    end

    scenario 'Allow user to delete a question' do
      # Open the question page
      visit question_path(@question)

      # Delete
      click_link 'Delete'
      page.accept_alert

      # Check if the question was deleted properly
      expect(page.current_path).to eq questions_path
      expect(page).not_to have_content(content)
      expect(page).not_to have_content(answer)
    end
  end


  scenario 'Allow user to provide formatting or styling for the question content' do
    # Open the new question page
    visit new_question_path

    # Fill in content
    styled_content = "# #{content}"
    fill_in_editor_field(styled_content)
    fill_in 'Answer', with: answer

    # Check preview
    expect(page).to have_css('h1', text: content)

    # Save
    click_button 'Save'

    # Check in the position page
    expect(page).to have_css('h1', text: content)

    # Open the edit question page
    click_link 'Edit'

    # Change style
    delete_text_in_editor_field(styled_content.length)
    fill_in_editor_field("## #{content}")

    # Check preview
    expect(page).to have_css('h2', text: content)

    # Save
    click_button 'Save'

    # Check in the position page
    expect(page).to have_css('h2', text: content)

    # Check in the quiz page
    click_link 'Quiz'
    expect(page).to have_css('h2', text: content)
  end

  private

    def fill_in_editor_field(text)
      within '.CodeMirror' do
        current_scope.click
        field = current_scope.find('textarea', visible: false)
        field.send_keys text
      end
    end

    def delete_text_in_editor_field(num)
      within '.CodeMirror' do
        current_scope.click
        field = current_scope.find('textarea', visible: false)
        field.send_keys Array.new(num, :backspace)
      end
    end
end
