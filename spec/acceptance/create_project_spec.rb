require 'spec_helper'

feature 'Create question', %q{
  I want to be able to create/update/delete projects
} do
  scenario 'User can create project' do
    new_project_title = 'New project' + Time.now.to_i.to_s

    visit new_project_path

    expect(page).to_not have_content new_project_title

    fill_in 'project_title', with: new_project_title
    click_on 'Create'

    expect(page).to have_content new_project_title
  end

  scenario 'User can edit project' do
    project = create(:project)
    new_project_title = 'New project title ' + Time.now.to_i.to_s

    visit edit_project_path(project)

    expect(page).to_not have_content new_project_title

    fill_in 'project_title', with: new_project_title
    click_on 'Change'

    expect(page).to have_content new_project_title
  end

  scenario 'User can remove project' do
    project = create(:project)

    visit projects_path

    expect(page).to have_content project.title

    click_on 'Remove'

    expect(page).to_not have_content project.title
  end
end
