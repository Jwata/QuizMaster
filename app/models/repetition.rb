class Repetition < ApplicationRecord
  belongs_to :question
  belongs_to :user

  def repeat(quality, time)
    spaced_repetition.repeat(quality, time)
    self.iteration = spaced_repetition.iteration
    self.interval = spaced_repetition.interval
    self.ef = spaced_repetition.ef
    self.due_at = spaced_repetition.due_at
    spaced_repetition
  end

  private

    def spaced_repetition
      @_sr ||= SpacedRepetition.new(
        iteration: iteration,
        interval: interval,
        ef: ef,
        due_at: due_at)
    end
end
