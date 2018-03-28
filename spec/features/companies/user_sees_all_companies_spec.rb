require 'rails_helper'

describe "User sees all companies" do
  scenario "a user sees all the companies" do
    company = Company.create!(name: "ESPN")
    company_two = Company.create!(name: "Disney")

    visit companies_path

    expect(page).to have_content("ESPN")
  end
  describe "User clicks links" do
    scenario "User clicks company link" do
      company = Company.create!(name: "ESPN")
      company_two = Company.create!(name: "Disney")
      visit "/companies"

      click_on("Disney")

      expect(current_path).to eq(company_path(company_two))
    end
    scenario "User clicks company edit link" do
      company = Company.create!(name: "ESPN")
      visit "/companies"

      click_on("Edit")


      expect(current_path).to eq(edit_company_path(company))
    end
    scenario "User clicks company edit link" do
      company = Company.create!(name: "ESPN")
      visit "/companies"

      click_on("Delete")

      expect(current_path).to eq(companies_path)
      expect(page).to have_content("ESPN was successfully deleted")
      expect(Company.all.count).to eq(0)
    end
  end
end
