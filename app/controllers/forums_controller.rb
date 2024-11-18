class ForumsController < ApplicationController
  before_action :set_course_and_lesson, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  before_action :set_forum, only: [:show, :edit, :update, :destroy]
  before_action :authorize_teacher!, only: [:edit, :update, :destroy]

  def index
    @forums = @lesson.forums
  end

  def show
    @questions = @forum.questions
    if params['question_id'].present?
      @question = @questions.find_by(id: params['question_id'])
      @answers = @question ? @question.answers : []
      redirect_to lesson_forum_path(@lesson, @forum), alert: "Question not found" unless @question
    else
      @answers = []
    end
    
    flash.now[:notice] = "No questions found for this forum." if @questions.empty?
  end

  def new
    @forum = @lesson.forums.new
  end

  def create
    @forum = @lesson.forums.new(forum_params)
    if @forum.save
      redirect_to course_lesson_forums_path(@course, @lesson), notice: 'Forum was successfully created.'
    else
      render :new
    end
  end
  
  def edit
    # La lógica de edición ya está protegida por el before_action :authorize_teacher!
  end

  def update
    if @forum.update(forum_params)
      redirect_to course_lesson_forums_path(@course, @lesson), notice: 'Forum was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @forum = @lesson.forums.find(params[:id]) # Ensure you find the forum first
    @forum.destroy
    flash[:notice] = 'Forum was successfully deleted.'
    redirect_to course_lesson_forums_path(@course, @lesson) # Use the correct path helper
  end

  private

  def set_course_and_lesson
    @course = Course.find(params[:course_id])               
    @lesson = @course.lessons.find(params[:lesson_id])      
  end

  def set_forum
    @forum = @lesson.forums.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to lesson_forums_path(@lesson), alert: "Forum not found."
  end

  def authorize_teacher!
    unless @course.teacher == current_utilizer
      redirect_back_or_to root_path, alert: "You are not authorized to #{action_name} this forum." 
    end
  end

  def forum_params
    params.require(:forum).permit(:title)
  end
end