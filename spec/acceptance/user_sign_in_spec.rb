require 'spec_helper'

feature 'User Sign In', %q{
  I want to be able sign in in order to use other functions.
} do
  given(:user) { create(:user) }

  scenario 'Registered user tries to sign in' do
    sign_in(user.email, user.password)

    expect(page).to_not have_content 'Log in'
    expect(page).to have_content user.email
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'Projects list'

    click_on 'Sign out'
    expect(page).to have_content 'Log in'
  end

  scenario 'Non-registered user tries to sign in' do
    sign_in('test@test.com', '123456')

    expect(page).to have_content 'Log in'
    expect(page).to_not have_content 'test@test.com'
    expect(page).to_not have_content 'Sign out'
    expect(page).to_not have_content 'Projects list'
  end

  scenario 'Impossible to sign in with incorrect password' do
    sign_in(user.email, '123456')

    expect(page).to have_content 'Log in'
    expect(page).to_not have_content user.email
    expect(page).to_not have_content 'Sign out'
    expect(page).to_not have_content 'Projects list'
  end
end
