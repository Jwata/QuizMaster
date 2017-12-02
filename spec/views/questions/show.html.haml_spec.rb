require 'rails_helper'

RSpec.describe "questions/show", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :content => "Content",
      :answer => "Answer"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/Answer/)
  end
end
