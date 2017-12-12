require 'rails_helper'

RSpec.describe Repetition, type: :model do
  describe '#repeat' do
    before do
      allow(repetition).to receive(:spaced_repetition).and_return(spaced_repetition)
    end

    let(:repetition) { described_class.new }
    let(:spaced_repetition) do
      double(:sr, repeat: nil, iteration: iteration, interval: interval, ef: ef, due_at: due_at)
    end
    let(:iteration) { 10 }
    let(:interval) { 10 }
    let(:ef) { 2.0 }
    let(:due_at) { Time.zone.tomorrow }

    it 'should update attributes' do
      expect do
        repetition.repeat(1, Time.zone.now)
      end.to change { repetition.iteration }.to(iteration)
        .and change { repetition.interval }.to(interval)
        .and change { repetition.ef }.to(ef)
        .and change { repetition.due_at }.to(due_at)
    end
  end
end
