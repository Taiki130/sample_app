class AddMicropostNullFalseWithUser < ActiveRecord::Migration[6.1]
  def change
    change_column :microposts, :user_id, :integer, null: false
  end
end
