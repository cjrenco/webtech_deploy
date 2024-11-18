class ChangeUtilizerIdToNotNullInCourseEnrollments < ActiveRecord::Migration[6.0]
  def change
    change_column_null :course_enrollments, :utilizer_id, false
  end
end
