class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.references :forum, null: false, foreign_key: true
      t.references :utilizer, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.datetime :date

      t.timestamps
    end
  end
end
