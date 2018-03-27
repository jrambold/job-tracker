require 'rails_helper'

describe "User edits an existing job" do
  scenario "a user can edit a job" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: "Category")
    job = company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver", category_id: category.id)

    visit edit_job_path(job)

    fill_in "job[title]", with: "BBaller"
    click_button "Update"

    expect(current_path).to eq("/jobs/#{Job.last.id}")
    expect(page).to have_content("BBaller")
    expect(page).to_not have_content("Developer")
  end
end
