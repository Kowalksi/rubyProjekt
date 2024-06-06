require 'rails_helper'

RSpec.feature 'User Sign In', type: :feature do
  let(:user) { create(:user) }

  scenario 'with valid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
  end

  scenario 'with invalid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
  end
end
