require 'rails_helper'

describe "User sees one category" do
  scenario "a user sees a category" do
    category = Category.create!(title: "Category")
    company = Company.create!(name: "Company")
    job = category.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver", category_id: category.id, company_id: company.id)

    visit category_path(category)

    expect(current_path).to eq("/categories/#{category.id}")
    expect(page).to have_content(category.title)
    expect(page).to have_content(job.title)
  end
end
