class AddDeletionCascade < ActiveRecord::Migration[7.2]
  def change

    remove_foreign_key :lessons, :courses if foreign_key_exists?(:lessons, :courses)
    add_foreign_key :lessons, :courses, on_delete: :cascade

    remove_foreign_key :forums, :lessons if foreign_key_exists?(:forums, :lessons)
    add_foreign_key :forums, :lessons, on_delete: :cascade

    remove_foreign_key :questions, :forums if foreign_key_exists?(:questions, :forums)
    add_foreign_key :questions, :forums, on_delete: :cascade

    remove_foreign_key :answers, :questions if foreign_key_exists?(:answers, :questions)
    add_foreign_key :answers, :questions, on_delete: :cascade
  end
end
