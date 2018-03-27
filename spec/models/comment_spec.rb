require 'rails_helper'

describe Comment do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without content" do
        comment = Comment.new()
        expect(comment).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name and job" do
        company = Company.new(name: "Turing")
        category = Category.create!(title: "Category")
        job = Job.create!(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
        comment = Comment.create!(content: "Adding content", job_id: job.id)
        expect(comment).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has a job" do
      job = Job.new(title: "Developer", description: "Wahoo", city: "Denver")
      comment = Comment.new(content: "Adding content", job_id: job.id)
      expect(comment).to respond_to(:job)
    end
  end
end
