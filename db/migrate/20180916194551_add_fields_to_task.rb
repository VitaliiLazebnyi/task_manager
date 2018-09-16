class AddFieldsToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :integer
    add_column :tasks, :deadline, :date
    add_column :tasks, :done,     :boolean
  end
end
