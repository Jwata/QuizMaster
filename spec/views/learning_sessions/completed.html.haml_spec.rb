require 'rails_helper'

RSpec.describe 'learning_sessions/completed', type: :view do
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/completed/)
  end
end
