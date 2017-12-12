class LearningSessionManager

  def self.new_session(user)
    LearningSession.from_question_ids(user, new_session_question_ids)
  end

  private

    def self.new_session_question_ids
      Question.all.pluck(:id).shuffle
    end
end
