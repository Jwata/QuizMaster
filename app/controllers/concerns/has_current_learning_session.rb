module HasCurrentLearningSession

  private

    def current_learning_session
      return unless session[:learning_session]
      LearningSession.new(session[:learning_session].deep_symbolize_keys)
    end
end
