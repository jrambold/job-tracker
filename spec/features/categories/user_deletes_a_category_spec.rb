require 'rails_helper'

describe "User deletes existing category" do
  scenario "a user can delete a category" do
    category = Category.create!(title: "Category")
    visit categories_path

    within("td") do
      click_link "Delete"
    end

    expect(page).to have_content("Category was successfully deleted!")
  end
end
