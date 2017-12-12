module HasCurrentLearningSession
  extend ActiveSupport::Concern

  included do
    helper_method :current_learning_session
  end

  def redirect_to_current_quiz
    return unless current_learning_session
    quiz_path = quiz_question_path(id: current_learning_session.current_question.id)
    return if request.path == quiz_path
    redirect_to quiz_path
  end

  private

    def current_learning_session
      return unless session[:learning_session]
      @_learning_session ||= LearningSession.new(session[:learning_session].deep_symbolize_keys)
    end
end
