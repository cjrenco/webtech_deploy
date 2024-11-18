class AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  
  def index
    @answers = @question.answers.includes(:utilizer)
  end

  
  def show
  end

 
  def new
    @answer = @question.answers.new
  end


  def create
    @answer = @question.answers.new(answer_params)
    @answer.utilizer = current_utilizer

    if @answer.save
      redirect_to course_lesson_forum_question_path(@question.forum.lesson.course, @question.forum.lesson, @question.forum, @question), notice: 'Answer was successfully created.'
    else
      render :new
    end
  end

 
  def edit
  end

 
  def update
    if @answer.update(answer_params)
      redirect_to course_lesson_forum_question_answer_path(@question.forum.lesson.course, @question.forum.lesson, @question, @answer), notice: 'Answer was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @answer.destroy
    redirect_to answers_redirect_path, notice: 'Answer was successfully deleted.'
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to answers_redirect_path, alert: "Answer not found."
  end

  def authorize_user!
    redirect_to answers_redirect_path, alert: "You are not authorized to #{action_name} this answer." unless @answer.utilizer == current_utilizer
  end

  def answer_params
    params.require(:answer).permit(:content)
  end

  def answers_redirect_path
    course_lesson_forum_question_answers_path(@question.forum.lesson.course, @question.forum.lesson, @question)
  end
end
