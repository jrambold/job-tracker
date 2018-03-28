require 'rails_helper'

describe "User sees all categories" do
  scenario "a user sees all the categories" do
    category = Category.create!(title: "Development")
    category_two = Category.create!(title: "Finance")

    visit categories_path

    expect(page).to have_content("Finance")
  end
  describe "User clicks links" do
    scenario "User clicks category title link" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "CEO")
      job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      visit "/categories"

      click_on(category.title)

      expect(current_path).to eq(category_path(category))
    end
    scenario "User clicks category jobs link" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "CEO")
      job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      visit "/categories"

      click_on("Jobs: 1")

      expect(current_path).to eq(category_path(category))
      expect(page).to have_content(job.title)
    end
    scenario "User clicks category edit link" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      job1 = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      visit "/categories"

      click_on("Edit")

      expect(current_path).to eq(edit_category_path(category))
    end
    scenario "User clicks category delete link" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      job1 = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      visit "/categories"

      click_on("Delete")

      expect(current_path).to eq(categories_path)
      expect(Category.count).to eq(0)
    end
  end
end
