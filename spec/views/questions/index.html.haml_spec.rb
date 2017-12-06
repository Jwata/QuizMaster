require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :content => "Content",
        :answer => "Answer"
      ),
      Question.create!(
        :content => "Content",
        :answer => "Answer"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select ".card", :count => 2
  end
end
