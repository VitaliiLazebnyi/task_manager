require 'spec_helper'
require 'date'

feature 'Task priorities', %q{
  I want to be able to prioritise tasks into a project
} do
  given(:user)        { create(:user) }
  given(:project)     { create(:project, user: user) }
  given!(:task)       { create(:task, project: project, priority: 1) }

  scenario 'User can change Priority with inline form' do
    old_task_priority = task.priority.to_s
    new_task_priority = '2'

    sign_in(user.email, user.password)

    visit project_path(project)

    # Check old priority
    expect(find_field('priority').value).to eq old_task_priority

    fill_in 'priority', with: new_task_priority
    click_on 'C'

    # Check that task was changed
    expect(find_field('priority').value).to eq new_task_priority

    # Reload page and check again
    visit project_path(project)
    expect(find_field('priority').value).to eq new_task_priority
  end
end
