require 'rails_helper'

describe "User" do
  scenario "a user can go to the home page" do
    visit root_path

    expect(current_path).to eq("/")
    expect(page).to have_content("This is the home page")
  end
  scenario "A user can navigate around the site" do
    visit root_path

  end
end
