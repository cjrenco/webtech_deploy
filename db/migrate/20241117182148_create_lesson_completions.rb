class CreateLessonCompletions < ActiveRecord::Migration[7.2]
  def change
    create_table :lesson_completions do |t|
      t.references :utilizer, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
