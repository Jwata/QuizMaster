class LearningSession
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :user, :questions, :current_index, :timestamp

  validates :questions, presence: true

  def self.from_question_ids(user, question_ids)
    questions = question_ids.map.with_index { |id, i| { index: i, id: id, results: [] } }
    self.new(user: user, current_index: 0, questions: questions)
  end

  def initialize(user: nil, questions: [], current_index: 0)
    self.user = user
    self.current_index = current_index
    self.questions = questions.map { |q| Question.new(q) }
    self.timestamp = Time.zone.now
  end

  def current_question
    return unless current_index
    questions[current_index]
  end

  def answer(result)
    update_user_repetition(result)
    current_question.results << result
    if next_question
      self.current_index = next_question.index
    else
      self.current_index = nil
    end
    self
  end

  def completed?
    current_index.nil?
  end

  def to_h
    {
      questions: questions.map(&:to_h),
      current_index: current_index
    }
  end

  private

    def next_question
      start = current_index + 1
      last = questions.length - 1
      question = questions[start..last].find(&:repeat?)
      (question) ? question : questions.find(&:repeat?)
    end

    def update_user_repetition(result)
      return unless current_question.results.empty?
      repetition = user.repetitions.find_or_initialize_by(question_id: current_question.id)
      # TODO change quality based on other response information
      # e.g. duration
      quality = (result) ? 5 : 1
      repetition.repeat(quality, timestamp)
      repetition.save
    end

    class Question
      include ActiveModel::Model

      attr_accessor :index, :id, :results

      def initialize(index:, id:, results: [])
        self.index = index
        self.id = id
        self.results = results
      end

      def repeat?
        results.last != true
      end

      def to_h
        {
          index: index,
          id: id,
          results: results
        }
      end
    end
end
