class AddRoleToUtilizers < ActiveRecord::Migration[6.0]
  def change
    add_column :utilizers, :role, :string, null: false, default: 'student'
  end
end
