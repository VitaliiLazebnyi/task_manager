class AddTasksToProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title

      t.timestamps
    end

    add_belongs_to :tasks, :project
  end
end
