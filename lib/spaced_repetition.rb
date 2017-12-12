# http://www.supermemo.com/english/ol/sm2.htm
class SpacedRepetition
  attr_accessor :iteration, :interval, :ef, :due_at

  INTERVAL_UNIT = :minute
  DEFAUlT_ITERATION = 1
  DEFAULT_EF = 2.5
  MIN_EF = 1.3

  def initialize(iteration: nil, interval: nil, ef: nil, due_at: nil)
    self.iteration = iteration || DEFAUlT_ITERATION
    self.interval = interval
    self.ef = ef || DEFAULT_EF
    self.due_at = due_at
  end

  def repeat(quality, time)
    self.iteration = 1 if quality < 3
    self.interval = next_interval(quality)
    self.ef = [next_ef(quality), MIN_EF].max
    self.iteration +=1
    self.due_at = time + interval.send(INTERVAL_UNIT)
    self
  end

  private

  def next_interval(quality)
    case iteration
    when 1
      1
    when 2
      6
    else
      (interval * ef).round
    end
  end

  def next_ef(q)
    ef + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
  end
end
