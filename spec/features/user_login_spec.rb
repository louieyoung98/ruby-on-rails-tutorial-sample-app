require "rails_helper"

RSpec.describe "User login", type: :feature do
  let(:user) { create :user }

  before do
    visit login_path
  end

  it "user can log in" do
    fill_in "Login", with: user.username
    fill_in "Password", with: user.password

    click_on "Login"

    expect(page).to have_current_path(user_path(user))
  end

  it "with invalid username" do
    fill_in "Login", with: "bad-username"
    fill_in "Password", with: user.password

    click_on "Login"

    expect(page).to have_current_path(login_path)
    expect(page).to have_text("Account does not exist")
  end

  it "with incorrect password" do
    fill_in "Login", with: user.username
    fill_in "Password", with: "bad-password"

    click_on "Login"

    expect(page).to have_current_path(login_path)
    expect(page).to have_text("Invalid Email/Username or Password")
  end

  context "when user logs in" do
    let(:user) { create :user, activated_at: nil}

    it "with inactive account and valid credentials" do
      fill_in "Login", with: user.username
      fill_in "Password", with: user.password

      click_on "Login"

      expect(page).to have_current_path(login_path)
      expect(page).to have_text("Account requires activation, check your email")
    end

    it "with inactive account and invalid username" do
      fill_in "Login", with: "bad-username"
      fill_in "Password", with: user.password

      click_on "Login"

      expect(page).to have_current_path(login_path)
      expect(page).to have_text("Account does not exist")
    end

    it "with inactive account and invalid password" do
      fill_in "Login", with: user.username
      fill_in "Password", with: "bad-password"

      click_on "Login"

      expect(page).to have_current_path(login_path)
      expect(page).to have_text("Account requires activation, check your email")
    end
  end
end
