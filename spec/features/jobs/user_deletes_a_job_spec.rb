require 'rails_helper'

describe "User deletes existing job" do
  scenario "a user can delete a job" do
    company = Company.create!(name: "ESPN")
    company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver")

    visit company_job_path(company, job)

    click_link "Delete"

    expect(page).to have_content("Developer was successfully deleted!")
  end
end
