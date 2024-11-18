class UpdateCreateUtilizers < ActiveRecord::Migration[7.2]
  def change
    change_table :utilizers do |t|
      t.remove :role
      t.integer :role_id
    end
  end
end
