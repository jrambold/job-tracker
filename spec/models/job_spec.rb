require 'rails_helper'

describe Job do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 80, )
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, category, and company" do
        company = Company.new(name: "Turing")
        category = Category.create!(title: "Category")
        job = Job.new(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
    end
  end

  describe "methods" do
    it "groups jobs by interest level" do
      company = Company.create!(name: "Turing")
      category = Category.create!(title: "Category")
      job1 = Job.create!(title: "Developer", level_of_interest: 5, city: "Denver", company_id: company.id, category_id: category.id)
      job2 = Job.create!(title: "Developer", level_of_interest: 40, city: "Denver", company_id: company.id, category_id: category.id)
      job3 = Job.create!(title: "Developer", level_of_interest: 60, city: "Denver", company_id: company.id, category_id: category.id)
      job4 = Job.create!(title: "Developer", level_of_interest: 80, city: "Denver", company_id: company.id, category_id: category.id)
      job5 = Job.create!(title: "Developer", level_of_interest: 110, city: "Denver", company_id: company.id, category_id: category.id)
      @jobs = Job.grouped_interest

      expected = {
        "1 to 25"=>1,
        "26 to 50"=>1,
        "51 to 75"=>1,
        "76 to 100"=>1,
        "101 to 125"=>1
      }

      expect(@jobs).to eq(expected)
    end
  end
end
