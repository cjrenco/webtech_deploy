class CoursesController < ApplicationController
  before_action :authenticate_utilizer!
  skip_before_action :authenticate_utilizer!, only: [:index]
  before_action :set_course, only: [:edit, :update, :destroy]
  before_action :authorize_teacher!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params['id'])
    @lessons = @course.lessons
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    
    # Verificar si el utilizador es un teacher
    if current_utilizer.teacher?
      @course.destroy
      redirect_to courses_path, notice: 'Course was successfully deleted.'
    else
      # Redirigir al curso con un mensaje de error
      redirect_to course_path(@course), alert: 'No tienes permiso para eliminar este curso.'
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def authorize_teacher!
    unless @course.teacher == current_utilizer
      redirect_back_or_to root_path, alert: "You are not authorized to #{action_name} this course." 
    end
  end

  def course_params
    params.require(:course).permit(:name, :category, :teacher_id)
  end
end