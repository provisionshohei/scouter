class RenameTypeColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :type, :character
  end
end
