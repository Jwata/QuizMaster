class LearningSessionsController < ApplicationController

  def show
    return redirect_to root_path unless current_learning_session
    if current_learning_session.completed?
      session[:learning_session] = nil
      render :completed
    else
      quiz_path = quiz_question_path(id: current_learning_session.current_question.id)
      redirect_to quiz_path
    end
  end

  def create
    @learning_session = LearningSessionManager.new_session
    session[:learning_session] = @learning_session.to_h
    redirect_to learning_session_path
  end

  private

    def current_learning_session
      return unless session[:learning_session]
      LearningSession.new(session[:learning_session])
    end
end
