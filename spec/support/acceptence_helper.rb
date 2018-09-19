module AcceptanceHelper
  def sign_in(email, password)
    visit root_path

    expect(page).to have_content 'Log in'

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
  end
end
