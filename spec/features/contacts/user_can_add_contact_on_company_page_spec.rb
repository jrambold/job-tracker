require 'rails_helper'

describe "User" do
  scenario "a user adds a contact to a company" do
    company = Company.create!(name: "ESPN")

    visit company_path(company)

    fill_in "contact[name]", with: "Adam"
    fill_in "contact[role]", with: "CEO"
    fill_in "contact[email]", with: "adam.n.conway@gmail.com"
    click_button "Create Contact"

    expect(current_path).to eq(company_path(company))
    expect(page).to have_content("CEO")
    expect(Contact.all.count).to eq(1)
  end
end
