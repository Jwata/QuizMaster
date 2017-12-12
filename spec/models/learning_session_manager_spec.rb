require 'rails_helper'

RSpec.describe LearningSessionManager, type: :model do
  describe '.new_session' do
    subject { described_class.new_session(user) }

    let(:user) { double(:user) }

    let(:questions_ids) { [1,2,3] }

    before do
      allow(Question).to receive_message_chain('all.pluck').with(:id) { questions_ids }
    end

    it { is_expected.to be_a LearningSession }
    it { expect(subject.questions.map(&:id)).to include(*questions_ids) }
  end
end

