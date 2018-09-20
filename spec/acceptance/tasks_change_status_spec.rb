require 'spec_helper'
require 'date'

feature 'Tasks', %q{
  I want to be able to prioritise tasks into a project
} do

  given(:user)        { create(:user) }
  given(:project)     { create(:project, user: user) }
  given!(:task)       { create(:task, project: project, done: false) }

  scenario 'User can change Status with inline form' do
    old_task_status   = 'Not done'
    new_task_status   = 'Done'

    sign_in(user.email, user.password)

    visit project_path(project)

    # Check old status
    expect(page).to have_content old_task_status

    click_on old_task_status

    # Check that task was changed
    expect(page).to have_content new_task_status

    # Reload page and check again
    visit project_path(project)
    expect(page).to have_content new_task_status
  end
end

