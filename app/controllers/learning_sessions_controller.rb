class LearningSessionsController < ApplicationController

  def show
    return redirect_to root_path unless current_learning_session
    if current_learning_session.completed?
      session[:learning_session] = nil
      render :completed
    elsif current_question
      quiz_path = quiz_question_path(current_question)
      redirect_to quiz_path
    else
      render :invalid_session
    end
  end

  def create
    learning_session = LearningSessionManager.new_session(current_user)
    if learning_session.valid?
      session[:learning_session] = learning_session.to_h
      redirect_to learning_session_path
    elsif learning_session.questions.empty?
      render :no_questions
    else
      flash[:error] = 'Failed to start learning session'
      redirect_to questions_path
    end
  end

  def destroy
    session[:learning_session] = nil
    redirect_to root_path
  end

  private

    def current_question
      Question.find_by(id: current_learning_session.current_question.id)
    end
end
