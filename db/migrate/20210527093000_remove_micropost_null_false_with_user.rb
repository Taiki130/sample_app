class RemoveMicropostNullFalseWithUser < ActiveRecord::Migration[6.1]
  def change
    change_column :microposts, :user_id, :integer, :null => true
  end
end
