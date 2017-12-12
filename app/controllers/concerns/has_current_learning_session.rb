module HasCurrentLearningSession
  extend ActiveSupport::Concern

  included do
    helper_method :current_learning_session
  end

  def redirect_to_current_quiz
    return unless current_learning_session
    return redirect_to learning_session_path if current_learning_session.completed?
    quiz_path = quiz_question_path(id: current_learning_session.current_question.id)
    return if request.path == quiz_path
    redirect_to quiz_path
  end

  private

    def current_learning_session
      return unless session[:learning_session]
      session_params = session[:learning_session]
        .deep_symbolize_keys.merge(user: current_user)
      @_learning_session ||= LearningSession.new(session_params)
    end
end
