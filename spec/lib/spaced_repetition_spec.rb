require 'rails_helper'

RSpec.describe SpacedRepetition do
  describe '#initialize' do
    subject { described_class.new }

    it { is_expected.to be_a described_class }
  end

  describe '#repeat' do
    let(:session_time) { Time.zone.now }

    context 'when the quality is < 3' do
      let(:spaced_repetition) { described_class.new(iteration: 10) }

      it 'resets iteration' do
        spaced_repetition.repeat(1, session_time)
        expect(spaced_repetition.iteration).to be 2

        spaced_repetition.repeat(2, session_time)
        expect(spaced_repetition.iteration).to be 2
      end
    end

    context 'when the quality is >= 3' do
      let(:spaced_repetition) { described_class.new(iteration: iteration) }
      let(:iteration) { 1 }

      it 'increments iteration' do
        spaced_repetition.repeat(3, session_time)
        expect(spaced_repetition.iteration).to be iteration+1

        spaced_repetition.repeat(4, session_time)
        expect(spaced_repetition.iteration).to be iteration+2

        spaced_repetition.repeat(5, session_time)
        expect(spaced_repetition.iteration).to be iteration+3
      end

      context 'when the iteration is 1' do
        subject(:interval) { spaced_repetition.interval }

        before { spaced_repetition.repeat(3, session_time) }

        let(:iteration) { 1 }

        it { is_expected.to eq 1 }
      end

      context 'when the iteration is 2' do
        subject(:interval) { spaced_repetition.interval }

        before { spaced_repetition.repeat(3, session_time) }

        let(:iteration) { 2 }

        it { is_expected.to eq 6 }
      end

      context 'when the iteration is >= 3' do
        subject(:next_interval) { spaced_repetition.interval }

        before { spaced_repetition.repeat(3, session_time) }

        let(:spaced_repetition) do
          described_class.new(iteration: iteration, ef: ef, interval: 1)
        end
        let(:interval) { 1 }
        let(:ef) { 2 }
        let(:iteration) { 3 }

        it { is_expected.to eq interval*ef }
      end
    end

    # Updating E-Factor
    [
      [2.5, 5, 2.5 + 0.1],
      [2.5, 4, 2.5],
      [2.5, 3, 2.5 - 0.14],
      [2.5, 2, 2.5 - 0.32],
      [2.5, 1, 2.5 - 0.54],
      [2.5, 0, 2.5 - 0.8],
      [1.5, 0, 1.3],
    ].each do |ef, q, ef_next|
      context "when the current ef is #{ef} and the quality is #{q}" do
        let(:spaced_repetition) { described_class.new(ef: ef) }

        before { spaced_repetition.repeat(q, Time.now) }

        it "should change ef to #{ef_next}" do
          expect(spaced_repetition.ef).to be_within(0.01).of(ef_next)
        end
      end
    end

  end
end
