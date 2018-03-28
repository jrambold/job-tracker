require 'rails_helper'

describe "User visits the dashboard" do
  describe "User uses nav bar" do
    scenario "User clicks dashboard" do
      visit "/"

      click_on("Dashboard")

      expect(current_path).to eq("/")
    end
    scenario "User clicks all companies" do
      visit "/"

      click_on("Company")
      click_on("All Companies")

      expect(current_path).to eq("/companies")
    end
    scenario "User clicks create a company" do
      visit "/"

      click_on("Company")
      click_on("Create A Company")

      expect(current_path).to eq("/companies/new")
    end
    scenario "User clicks on all jobs" do
      visit "/"

      click_on("Job")
      click_on("All Jobs")

      expect(current_path).to eq("/jobs")
    end
    scenario "User clicks on create a job" do
      visit "/"

      click_on("Job")
      click_on("Create A Job")

      expect(current_path).to eq("/jobs/new")
    end
    scenario "User clicks on all categories" do
      visit "/"

      click_on("Category")
      click_on("All Categories")

      expect(current_path).to eq("/categories")
    end
    scenario "User clicks on create a category" do
      visit "/"

      click_on("Category")
      click_on("Create A Category")

      expect(current_path).to eq("/categories/new")
    end
  end

  describe "User navigates with dashboard links" do
    scenario "User clicks on a company link in companies by interest" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver", company_id: company.id, category_id: category.id)
      visit "/"

      click_on("ESPN")

      expect(current_path).to eq(company_jobs_path(company))
    end
    scenario "User clicks on a job location link in jobs by location" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      job1 = company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver", company_id: company.id, category_id: category.id)
      job2 = company.jobs.create!(title: "Developer", level_of_interest: 90, city: "SF", company_id: company.id, category_id: category.id)
      visit "/"

      click_on("Denver")

      expect(current_path).to eq("/jobs")
      expect(page).to have_content("Denver")
      expect(page).to_not have_content("SF")
    end
  end
end
