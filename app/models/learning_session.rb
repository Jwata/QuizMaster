class LearningSession
  include ActiveModel::Model

  attr_accessor :questions, :current_index

  def self.from_question_ids(question_ids)
    questions = question_ids.map.with_index { |id, i| { index: i, id: id, results: [] } }
    self.new(current_index: 0, questions: questions)
  end

  def initialize(questions: [], current_index: 0)
    self.current_index = current_index
    self.questions = questions.map { |q| Question.new(q) }
  end

  def current_question
    return unless current_index
    questions[current_index]
  end

  def answer(result)
    current_question.results << result
    if next_question
      self.current_index = next_question.index
    else
      self.current_index = nil
    end
    nil
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

    def question(index)
      questions[index]
    end

    def next_question
      start = current_index + 1
      last = questions.length - 1
      question = questions[start..last].find(&:repeat?)
      (question) ? question : questions.find(&:repeat?)
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
