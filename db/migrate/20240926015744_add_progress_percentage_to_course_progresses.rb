class AddProgressPercentageToCourseProgresses < ActiveRecord::Migration[6.0]
  def change
    add_column :course_progresses, :progress_percentage, :decimal, precision: 5, scale: 2, null: false, default: 0.0
  end
end
