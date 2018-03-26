require 'rails_helper'

describe "User sees one job" do
  scenario "a user sees a job" do
    company = Company.create!(name: "ESPN")
    company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver")

    visit company_job_path(company)

    expect(current_path).to eq("/jobs/#{jobs.id}/jobs")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
  end
end
