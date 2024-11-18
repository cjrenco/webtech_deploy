class CreateUtilizers < ActiveRecord::Migration[7.2]
  def change
    create_table :utilizers do |t|
      t.string :email
      t.string :login
      t.string :password
      t.string :name
      t.string :last_name
      t.string :role

      t.timestamps
    end
  end
end
