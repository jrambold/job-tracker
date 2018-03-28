require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        Company.create(name: "Dropbox")
        company = Company.new(name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
  end

  describe "methods" do
    it "calculates top 3 companies by interest" do
      company0 = Company.create!(name: "Dropbox")
      company1 = Company.create!(name: "ASDF")
      company2 = Company.create!(name: "JKL")
      category = Category.create!(title: "Category")
      Job.create!(title: "Developer", level_of_interest: 40, city: "Denver", company: company0, category_id: category.id)
      Job.create!(title: "Developer", level_of_interest: 20, city: "Denver", company: company0, category_id: category.id)
      Job.create!(title: "Developer", level_of_interest: 90, city: "Denver", company: company1, category_id: category.id)
      Job.create!(title: "Developer", level_of_interest: 25, city: "Denver", company: company2, category_id: category.id)
      Job.create!(title: "Developer", level_of_interest: 50, city: "Denver", company: company2, category_id: category.id)
      Job.create!(title: "Developer", level_of_interest: 75, city: "Denver", company: company2, category_id: category.id)

      top = Company.top_companies
      
      expect(top.first.name).to eq(company1.name)
      expect(top.last.name).to eq(company0.name)
    end
  end
end
