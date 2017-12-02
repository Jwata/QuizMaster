require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '#correct?' do
    subject { question.correct?(answer) }

    let(:question) { Question.new(answer: correct_answer) }
    let(:correct_answer) { 'Mount Fuji' }
    let(:answer) { '' }

    context 'when the input is the same with the answer' do
      let(:answer) { correct_answer }
      it { is_expected.to be_truthy }
    end

    context 'when the answer is number' do
      let(:correct_answer) { '110' }

      context 'and the input is a word of the number' do
        let(:answer) { 'one hundred and ten' }
        it { is_expected.to be_truthy }
      end
    end

    context 'when the answer contains number' do
      let(:correct_answer) { '110 meters' }

      context 'and the input is a word of the number' do
        let(:answer) { 'one hundred and ten meters' }
        it { is_expected.to be_truthy }
      end
    end

    context 'when the input is wrong' do
      let(:answer) { 'Wrong answer' }
      it { is_expected.to be_falsey }
    end
  end
end
