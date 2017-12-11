require 'rails_helper'

RSpec.describe LearningSessionManager, type: :model do
  describe '.new_session' do
    subject { described_class.new_session }

    before do
      allow(Question).to receive_message_chain('all.pluck').with(:id) { questions_ids }
    end
    let(:questions_ids) { [1,2,3] }

    it { is_expected.to be_a LearningSession }
    it { expect(subject.questions.map(&:id)).to include(*questions_ids) }
  end
end

