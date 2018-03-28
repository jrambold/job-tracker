require 'rails_helper'

describe "User sees all jobs" do
  scenario "a user sees all the jobs for a specific company" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: "Category")
    company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
    company.jobs.create!(title: "QA Analyst", level_of_interest: 70, city: "New York City", category_id: category.id)

    visit company_jobs_path(company)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
  end
  describe "User clicks links" do
    scenario "User clicks job title link" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      visit "/jobs"

      click_on(job.title)

      expect(current_path).to eq(job_path(job))
    end
    scenario "User clicks job title link" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      visit "/jobs"

      click_on(company.name)

      expect(current_path).to eq(company_path(company))
    end
    scenario "User clicks job citt link" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      job1 = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      job2 = company.jobs.create!(title: "Writer", level_of_interest: 70, city: "Seattle", category_id: category.id)
      visit "/jobs"

      click_on(job1.city)

      expect(current_path).to eq(jobs_path)
      expect(page).to have_content(job1.city)
      expect(page).to_not have_content(job2.city)
    end
    scenario "User clicks job edit link" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      job1 = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      visit "/jobs"

      click_on("Edit")

      expect(current_path).to eq(edit_job_path(job1))
    end
    scenario "User clicks job delete link" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      job1 = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      visit "/jobs"

      click_on("Delete")

      expect(current_path).to eq(company_path(company))
      expect(company.jobs.count).to eq(0)
    end
  end
end
