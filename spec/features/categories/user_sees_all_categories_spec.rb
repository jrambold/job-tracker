require 'rails_helper'

describe "User sees all categories" do
  scenario "a user sees all the categories" do
    category = Category.create!(title: "Development")
    category_two = Category.create!(title: "Finance")

    visit categories_path
    save_and_open_page

    expect(page).to have_content("Finance")
  end
end
