require 'rails_helper'

describe Contact do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without name" do
        contact = Contact.new(role: "CEO", email: "adam.n.conway@gmail.com")
        expect(contact).to be_invalid
      end
      it "is invalid without role" do
        contact = Contact.new(name: "Adam", email: "adam.n.conway@gmail.com")
        expect(contact).to be_invalid
      end
      it "is invalid without email" do
        contact = Contact.new(name: "Adam", role: "CEO")
        expect(contact).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name, role, and email" do
        company = Company.create!(name: "Turing")
        contact = company.contacts.create!(name: "Adam", role: "CEO", email: "adam.n.conway@gmail.com")
        expect(contact).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has a company" do
      company = Company.create!(name: "Turing")
      contact = company.contacts.create!(name: "Adam", role: "CEO", email: "adam.n.conway@gmail.com")
      expect(contact).to respond_to(:company)
    end
  end
end
