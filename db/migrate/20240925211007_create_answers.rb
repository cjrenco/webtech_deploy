class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.references :question, null: false, foreign_key: true
      t.references :utilizer, null: false, foreign_key: true
      t.text :content
      t.datetime :date

      t.timestamps
    end
  end
end
