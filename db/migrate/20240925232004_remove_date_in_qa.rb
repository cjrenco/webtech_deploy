class RemoveDateInQa < ActiveRecord::Migration[7.2]
  def change
    change_table :questions do |t|
      t.remove :date
    end
    change_table :answers do |t|
      t.remove :date
    end
  end
end
