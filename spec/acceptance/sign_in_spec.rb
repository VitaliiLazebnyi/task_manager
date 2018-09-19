require 'spec_helper'

feature 'Create question', %q{
  I want to be able sign in in order to use other functions.
} do
  scenario 'Registered user tries to sign in' do
    User.create!(email: 'test@test.com', password: '666666')

    visit root_path

    expect(page).to have_content 'Log in'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '666666'
    click_on 'Log in'

    expect(page).to_not have_content 'Log in'
    expect(page).to have_content 'test@test.com'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'Projects list'

    click_on 'Sign out'
    expect(page).to have_content 'Log in'
  end

  scenario 'Non-registered user tries to sign in' do
    visit root_path

    expect(page).to have_content 'Log in'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '666666'
    click_on 'Log in'

    expect(page).to have_content 'Log in'
    expect(page).to_not have_content 'test@test.com'
    expect(page).to_not have_content 'Sign out'
    expect(page).to_not have_content 'Projects list'
  end
end
