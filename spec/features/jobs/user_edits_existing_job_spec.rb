require 'rails_helper'

describe "User edits an existing company" do
  scenario "a user can edit a company" do
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver")

    visit edit_company_job_path(company, job)

    fill_in "job[title]", with: "BBaller"
    click_button "Update"

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
    expect(page).to have_content("BBaller")
    expect(page).to_not have_content("Developer")
  end
end
