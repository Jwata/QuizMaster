class LearningSessionManager

  def self.new_session(user)
    question_ids = new_session_question_ids(user)
    LearningSession.from_question_ids(user, question_ids)
  end

  private

    def self.new_session_question_ids(user)
      ids = user.repetitions.where('due_at < ?', Time.zone.now).pluck(:question_id)
      learned_ids = user.repetitions.pluck(:question_id)
      ids += Question.where.not(id: learned_ids).pluck(:id)
      ids.shuffle
    end
end
