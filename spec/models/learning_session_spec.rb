require 'rails_helper'

RSpec.describe LearningSession, type: :model do
  describe '.from_question_ids' do
    subject { described_class.from_question_ids(question_ids) }

    let(:question_ids) { [1, 2, 3] }

    it 'creates an instance from the given question ids' do
      session = subject
      expect(session).to be_a LearningSession
      expect(session.current_question).to be_a LearningSession::Question
      expect(session.questions.map(&:id)).to eq question_ids
    end
  end

  describe '#initialize' do
    subject { described_class.new(init_params) }

    let(:init_params) do
      {
        questions: [
          { index: 0, id: 1, results: [true] },
          { index: 1, id: 2, results: [false, false] }
        ],
        current_index: 1
      }
    end

    it 'initializes an instance from the given params' do
      session = subject
      expect(session).to be_a LearningSession
      expect(session.current_question).to be_a LearningSession::Question
      expect(session.questions.map(&:id)).to eq [1, 2]
    end
  end

  describe '#current_question' do
    subject { learning_session.current_question }

    let(:learning_session) { described_class.new(init_params) }
    let(:init_params) do
      { questions: [ question_1, question_2 ], current_index: 1 }
    end
    let(:question_1) { { index: 0, id: 1, results: [] } }
    let(:question_2) { { index: 1, id: 2, results: [] } }

    it { is_expected.to be_a LearningSession::Question }
    it { expect(subject.id).to eq question_2[:id] }

    context "when the session doesn't have the current question" do
      let(:init_params) do
        { questions: [ question_1, question_2 ], current_index: nil }
      end
      let(:question_1) { { index: 0, id: 1, results: [false] } }
      let(:question_2) { { index: 1, id: 2, results: [false] } }

      it { is_expected.to be_nil }
    end
  end

  describe '#answer' do
    let(:learning_session) { described_class.new(init_params) }
    let(:init_params) do
      { questions: [ question_1, question_2 ], current_index: 0 }
    end
    let(:question_1) { { index: 0, id: 1, results: [] } }
    let(:question_2) { { index: 1, id: 2, results: [] } }
    let(:result) { true }

    it 'stores the given result to the current question' do
      current_index = learning_session.current_index
      expect { learning_session.answer(result) }
        .to change { learning_session.questions[current_index].results }
        .from([]).to([result])
    end

    it 'changes the current question to next' do
      expect { learning_session.answer(result) }
        .to change { learning_session.current_question.id }
        .from(1).to(2)
    end

    context 'when some of the following questions have been answered correctly' do
      let(:init_params) do
        { questions: [ question_1, question_2, question_3 ], current_index: 0 }
      end
      let(:question_1) { { index: 0, id: 1, results: [false] } }
      let(:question_2) { { index: 1, id: 2, results: [true] } }
      let(:question_3) { { index: 2, id: 3, results: [false] } }

      it "skips them and goes the next failed question" do
        expect { learning_session.answer(result) }
          .to change { learning_session.current_question.id }
          .from(1).to(3)
      end
    end

    context 'when all the following questions have been answered correctly' do
      let(:init_params) do
        { questions: [ question_1, question_2, question_3 ], current_index: 1 }
      end
      let(:question_1) { { index: 0, id: 1, results: [false, false] } }
      let(:question_2) { { index: 1, id: 2, results: [false] } }
      let(:question_3) { { index: 2, id: 3, results: [true] } }

      it "backs to the top of the questions" do
        expect { learning_session.answer(result) }
          .to change { learning_session.current_question.id }
          .from(2).to(1)
      end
    end

    context 'when all the questions get answered correctly' do
      let(:init_params) do
        { questions: [ question_1, question_2, question_3 ], current_index: 1 }
      end
      let(:question_1) { { index: 0, id: 1, results: [false, true] } }
      let(:question_2) { { index: 1, id: 2, results: [false] } }
      let(:question_3) { { index: 2, id: 3, results: [true] } }

      it "doesn't set question any more" do
        expect { learning_session.answer(true) }
          .to change { learning_session.current_question }
          .to(nil)
      end
    end
  end

  describe '#completed?' do
    subject { learning_session.completed? }

    let(:learning_session) { described_class.from_question_ids(question_ids) }
    let(:question_ids) { [1, 2] }
    let(:question_count) { question_ids.count }

    context 'when all the questions have been answered correctly' do
      before do
        question_count.times { learning_session.answer(true) }
      end

      it { is_expected.to be_truthy }
    end

    context 'when some of the questions have not been answered correctly yet' do
      before do
        (question_count-1).times { learning_session.answer(true) }
      end

      it { is_expected.to be_falsey }
    end
  end

  describe '#to_h' do
    subject { learning_session.to_h }

    let(:learning_session) { described_class.new(init_params) }
    let(:init_params) do
      {
        questions: [ question_1, question_2 ],
        current_index: 1
      }
    end
    let(:question_1) { { index: 0, id: 1, results: [] } }
    let(:question_2) { { index: 1, id: 2, results: [] } }

    it { is_expected.to eq init_params }
  end
end
