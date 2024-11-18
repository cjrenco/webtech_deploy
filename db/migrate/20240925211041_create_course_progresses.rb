class CreateCourseProgresses < ActiveRecord::Migration[7.2]
  def change
    create_table :course_progresses do |t|
      t.references :utilizer, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :completed_lessons

      t.timestamps
    end
  end
end
