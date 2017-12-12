class QuestionsController < ApplicationController
  include HasCurrentLearningSession

  before_action :set_question, only: [:show, :edit, :update, :destroy, :quiz, :check_answer]
  after_action :save_answer_to_learning_session, only: :check_answer, if: -> { current_learning_session.present? }

  before_action :redirect_to_current_quiz, except: :check_answer

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def quiz
  end

  def check_answer
    @quiz_result = @question.correct?(quiz_answer_param)
    flash[:quiz_result] = @quiz_result
    flash[:quiz_answer] = quiz_answer_param
    respond_to do |format|
      format.html { redirect_to quiz_question_path }
      format.json { render :quiz, status: :ok, location: @question }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content, :answer)
    end

    def quiz_answer_param
      params.require(:quiz).require(:answer)
    end

    def save_answer_to_learning_session
      current_learning_session.answer(@quiz_result)
      session[:learning_session] = current_learning_session.to_h
    end
end
