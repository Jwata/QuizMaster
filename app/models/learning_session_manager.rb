class LearningSessionManager

  def self.new_session
    LearningSession.from_question_ids(new_session_question_ids)
  end

  private

    def self.new_session_question_ids
      Question.all.pluck(:id).shuffle
    end
end
