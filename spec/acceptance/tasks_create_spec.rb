require 'spec_helper'

feature 'Create Tasks', %q{
  I want to be able to add tasks to my project
} do

  given(:user)    { create(:user) }
  given(:project) { create(:project, user: user) }

  scenario 'User can create Task in existing Project' do
    task_title  = '1st task in the project'
    task_status = 'Not done'

    sign_in(user.email, user.password)

    visit project_path(project)

    # Check absence of Tasks
    expect(page).to have_content "There's no Tasks in the Project."

    click_on 'Add new Task'

    fill_in 'task_title', with: task_title
    click_on 'Create'

    # Check that task was created
    expect(page).to have_content task_title
    expect(find('.status').value).to eq task_status
  end
end
