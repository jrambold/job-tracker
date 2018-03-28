require 'rails_helper'

describe "User sees one job" do
  scenario "a user sees a job" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: "Category")
    company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver", category_id: category.id)

    visit job_path(company.jobs.first)

    expect(current_path).to eq("/jobs/1")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
  end
end
