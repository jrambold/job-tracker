require 'rails_helper'

describe "User deletes an existing contact" do
  scenario "a user can delete contact" do
    company = Company.create!(name: "ESPN")
    contact = company.contacts.create!(name: "Adam", role:"CEO", email: "Adam.m.conway@gmail.com")

    visit company_path(company)
    save_and_open_page
    click_link "Delete"
    save_and_open_page

    expect(current_path).to eq(company_path(company))
    expect(page).to_not have_content(contact.email)
  end
end
