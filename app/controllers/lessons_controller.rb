class LessonsController < ApplicationController
  before_action :set_course, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  before_action :authorize_teacher!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @lessons = @course.lessons
  end

  def show
    @lesson = @course.lessons.find(params[:id])
    @forums = @lesson.forums
  end

  def new
    @lesson = @course.lessons.new
  end

  def create
    @lesson = @course.lessons.new(lesson_params)
    if @lesson.save
      redirect_to [@course, @lesson], notice: "Lesson was successfully created."
    else
      render :new
    end
  end

  def edit
    @lesson = @course.lessons.find_by(id: params[:id])
    if @lesson.nil?
      redirect_to course_lessons_path(@course), alert: 'Lesson not found.'
    end
  end
  
  def update
    @lesson = @course.lessons.find(params[:id])
    if @lesson.update(lesson_params)
      flash[:notice] = "Lesson was successfully updated."
      redirect_to course_path(@course)
    else
      render :edit
    end
  end

  def destroy
    @lesson = @course.lessons.find_by(id: params[:id])
    if @lesson
      @lesson.destroy
      flash[:notice] = 'Lesson was successfully deleted.'
    else
      flash[:alert] = 'Lesson not found or does not belong to this course.'
    end
    redirect_to course_path(@course)
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def authorize_teacher!
    unless @course.teacher == current_utilizer
      redirect_back_or_to root_path, alert: "You are not authorized to #{action_name} this lesson."
    end
  end

  def lesson_params
    params.require(:lesson).permit(:title, :content, :course_id)
  end
end