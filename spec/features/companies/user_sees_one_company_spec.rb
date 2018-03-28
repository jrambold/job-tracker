require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company" do
    company = Company.create!(name: "ESPN")

    visit company_path(company)

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content("ESPN")
  end
  scenario "a user sees a company contact" do
    company = Company.create!(name: "ESPN")
    contact = company.contacts.create!(name: "Adam", role: "CEO", email: "adam.n.conway@gmail.com")

    visit company_path(company)

    expect(page).to have_content("adam.n.conway@gmail.com")

    click_on("Delete")

    expect(page).to_not have_content("adam.n.conway@gmail.com")
  end
  describe "User clicks links" do
    scenario "User clicks jobs link for company" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Category")
      job1 = company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver", company_id: company.id, category_id: category.id)
      job2 = company.jobs.create!(title: "Writer", level_of_interest: 90, city: "SF", company_id: company.id, category_id: category.id)
      visit company_path(company)

      click_on("Check out ESPN's jobs!")

      expect(current_path).to eq(company_jobs_path(company))
      expect(page).to have_content("Developer")
      expect(page).to have_content("Writer")
    end
  end
end
