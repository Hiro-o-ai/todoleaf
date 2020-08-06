class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def up
    execute "DELETE FROM tasks;"
    add_reference :tasks, :user, index: true
    change_column_null :tasks, :user_id, false
  end

  def down
    remove_reference :tasks, :user, index: true
  end
end
