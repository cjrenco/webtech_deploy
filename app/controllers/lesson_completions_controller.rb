class LessonCompletionsController < ApplicationController
    before_action :set_lesson
  
    def create
        Rails.logger.debug("Creating LessonCompletion for user #{current_utilizer.id} and lesson #{@lesson.id}")
        LessonCompletion.create!(utilizer: current_utilizer, lesson: @lesson)
        redirect_to course_path(@lesson.course), notice: 'Lesson marked as complete.'
      end
      
      def destroy
        Rails.logger.debug("Destroying LessonCompletion for user #{current_utilizer.id} and lesson #{@lesson.id}")
        completion = LessonCompletion.find_by(utilizer: current_utilizer, lesson: @lesson)
        completion.destroy if completion
        redirect_to course_path(@lesson.course), notice: 'Lesson marked as incomplete.'
      end
    
  
    private
  
    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end
  end
  