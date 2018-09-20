require 'spec_helper'
require 'date'

feature 'Edit and remove Tasks', %q{
  I want to be able to add tasks to my project
} do

  given(:user)    { create(:user) }
  given(:project) { create(:project, user: user) }
  given!(:task)   { create(:task, project: project, done: false, priority: 1) }

  scenario 'User can edit Task' do
    old_task_title    = task.title
    new_task_title    = 'check title edit possibility'
    old_task_deadline = task.deadline
    new_task_deadline = Date.today + 5
    old_task_status   = 'Not done'
    new_task_status   = 'Done'
    old_task_priority = task.priority.to_s
    new_task_priority = '4'

    sign_in(user.email, user.password)

    visit project_path(project)

    # Check presence of old Task data
    expect(page).to have_content old_task_title
    expect(page).to have_content old_task_status
    expect(page).to have_content old_task_deadline
    expect(find_field('priority').value).to eq old_task_priority

    click_on 'Edit'

    fill_in  'task_title',    with: new_task_title
    fill_in  'task_deadline', with: new_task_deadline
    check    'task_done'
    select   new_task_priority, from: 'task_priority'
    click_on 'Change'

    # Check that task was changed
    expect(page).to_not have_content old_task_title
    expect(page).to_not have_content old_task_status
    expect(page).to have_content new_task_title
    expect(page).to have_content new_task_deadline
    expect(page).to have_content new_task_status
    expect(find_field('priority').value).to eq new_task_priority
  end

  scenario 'User can remove Task' do
    task_status = 'Not done'

    sign_in(user.email, user.password)

    visit project_path(project)

    # Check presence of Task data
    expect(page).to have_content task.title
    expect(page).to have_content task_status

    click_on 'Remove'

    # Check that task was changed
    expect(page).to_not have_content task.title
    expect(page).to_not have_content task_status
  end
end
