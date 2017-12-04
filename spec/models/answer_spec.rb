require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe '#correct?' do
    subject { answer.correct?(input) }

    let(:answer) { Answer.new(correct) }
    let(:correct) { 'Mount Fuji' }
    let(:input) { '' }

    context 'when the input is the same with the correct answer' do
      let(:input) { correct }
      it { is_expected.to be_truthy }
    end

    context 'when the correct answer is number' do
      let(:correct) { '110' }

      context 'and the input is a word of the number' do
        let(:input) { 'one hundred and ten' }
        it { is_expected.to be_truthy }
      end
    end

    context 'when the correct answer contains number' do
      let(:correct) { '110 meters' }

      context 'and the input is a word of the number' do
        let(:input) { 'one hundred and ten meters' }
        it { is_expected.to be_truthy }
      end
    end

    context 'when the input is wrong' do
      let(:correct) { 'Wrong answer' }
      it { is_expected.to be_falsey }
    end
  end
end

