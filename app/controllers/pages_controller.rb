class PagesController < ApplicationController
 
    def about
      # Logic for about page (if any)
    end
  
    def contact
      # Logic for contact page (if any)
    end
    
    def home
      @latest_courses = Course.order(created_at: :desc).limit(3)
    end
  end
  