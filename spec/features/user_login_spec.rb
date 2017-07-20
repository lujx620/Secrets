require 'rails_helper'
feature 'authentication' do
  before do
    @user = create(:user)
  end
  feature 'user sign-in' do
    scenario 'visit sign-in page' do
      visit '/'
      expect(page).to have_field('email')
      expect(page).to have_field('password')
    end
    scenario 'logs in user if email/password combination is valid' do
      log_in
      expect(current_path).to eq('/users/#{@user.id}')
      expect(page).to have_text(@current_user.name)
    end
    scenario 'does not sign in user if email is not found' do
      log_in email: 'wrong email'
      expect(current_path).to eq('/')
      expect(page).to have_text('email/password does not match')
    end
    scenario 'does not sign in user if email/password combination is invalid' do
      log_in password: 'wrong password'
      expect(current_path).to eq('/')
      expect(page).to have_text('email/password does not match')
    end
  end
  feature 'user to log out' do
    before do
      log_in
    end
    scenario "displays 'Log Out'button when user is logged on" do
      expect(page).to have_button('Log Out')
    end
    scenario 'logs out user and redirect to login page' do
      click_button 'Log Out'
      expect(current_path).to eq('/')
    end
  end
end
