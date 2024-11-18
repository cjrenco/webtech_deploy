namespace :db do
    task :model_queries => :environment do    
    puts("Query 0: Sample query; show all the users")    
    result = Utilizer.all    
    puts(result)    
    puts("EOQ")

    #Query 1
    student = Utilizer.joins(:course_enrollments)
                  .where(role: 'student')
                  .group('utilizers.id')
                  .order('COUNT(course_enrollments.id) DESC')
                  .limit(1)
                  .pluck(:name, :last_name)
    puts "Query 1: Most enrolled student: #{student.join(' ')}"
    puts "EOQ"
    
    #Query 2
    course = Course.joins(:lessons)
                    .group('courses.id')
                    .order('COUNT(lessons.id) DESC')
                    .limit(1)
                    .pluck(:name)
    puts "Query 2: Course with the most lessons: #{course.first}"
    puts("EOQ")

    #Query 3
    teacher = Utilizer.joins(:courses)
                    .where(role: 'teacher')
                    .group('utilizers.id')
                    .order('COUNT(courses.id) DESC')
                    .limit(1)
                    .pluck(:name, :last_name)
    puts "Query 3: Teacher with the most created courses: #{teacher.join(' ')}"
    puts("EOQ")

    #Query 4
    recent_courses = Course.order(created_at: :desc).limit(3).pluck(:name)
    puts "Query 4: Last 3 created courses: #{recent_courses.join(', ')}"
    puts("EOQ")

    # Query 5
    student_with_max_progress = Utilizer.joins(:course_progresses)
                                        .where(role: 'student')
                                        .order('course_progresses.progress_percentage DESC')
                                        .limit(1)
                                        .pluck(:name, :last_name)

    puts "Query 5: Student with most progress: #{student_with_max_progress.join(' ')}"
    puts "EOQ"

    #Query 6
    course = Course.joins(:course_enrollments)
                                        .group('courses.id')
                                        .order('COUNT(course_enrollments.id) DESC')
                                        .limit(1)
                                        .pluck(:name)
    puts "Query 6: Course with the most students: #{course.first}"
    puts("EOQ")

    #Query 7
    course_with_most_completions = Course.joins(:course_progresses, :lessons)
                                        .group('courses.id')
                                        .having('COUNT(lessons.id) = MAX(course_progresses.completed_lessons)')
                                        .order('COUNT(course_progresses.id) DESC')
                                        .limit(1)
                                        .pluck('courses.name, COUNT(lessons.id) AS lesson_count')
    puts "Query 7: Course with the most completions: #{course_with_most_completions.first}"
    end       
end