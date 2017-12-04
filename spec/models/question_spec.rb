require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '#correct?' do
    subject { question.correct?(input) }

    let(:question) { Question.new(answer: correct_answer) }
    let(:correct_answer) { 'Mount Fuji' }
    let(:input) { 'Some answer' }

    it 'delegates to answer' do
      answer_double = double(:answer)
      expect(question).to receive(:answer).and_return(answer_double)
      expect(answer_double).to receive(:correct?).with(input).and_return(true)
      expect(subject).to be_truthy
    end
  end

  describe '#answer' do
    subject { question.answer }

    let(:question) { Question.new(answer: correct_answer) }
    let(:correct_answer) { 'Mount Fuji' }

    it 'returns answer object' do
      expect(subject).to be_a Answer
      expect(subject.to_s).to be correct_answer
    end
  end

  describe '#answer=' do
    let(:question) { Question.new(answer: 'Old answer') }
    let(:new_answer) { 'New answer' }

    it 'sets the given answer' do
      question.answer = new_answer
      expect(question.answer.to_s).to be new_answer
    end
  end

  describe '#save' do
    let(:question) { Question.new(content: content, answer: answer) }
    let(:content) { "What's the higest mountain in Japan?" }
    let(:answer) { 'Mount Fuji' }

    it 'persists the content and the answer' do
      expect(question.save).to be_truthy
      question.reload
      expect(question.content).to eq content
      expect(question.answer.to_s).to eq answer
    end
  end

  describe '#validate' do
    subject { question.validate }

    let(:question) { Question.new(content: content, answer: answer) }
    let(:content) { "What's the higest mountain in Japan?" }
    let(:answer) { 'Mount Fuji' }

    context 'when the content and the answer are present' do
      it { is_expected.to be_truthy }
    end

    context 'when the content is blank' do
      let(:content) { '' }
      it { is_expected.to be_falsey }
    end

    context 'when the answer is blank' do
      let(:answer) { '' }
      it { is_expected.to be_falsey }
    end
  end
end
