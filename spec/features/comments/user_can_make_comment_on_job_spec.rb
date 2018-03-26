require 'rails_helper'

describe "User sees one job" do
  scenario "a user leaves a comment on a job" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: "Category")
    job = company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver", category_id: category.id)

    visit company_job_path(company, job)

    fill_in "comment[content]", with: "Adding a comment"
    click_button "Create Comment"

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content("Adding a comment")
    expect(Comment.all.count).to eq(1)
  end
end
