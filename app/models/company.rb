class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def self.top_companies
    Company.select('companies.id, companies.name, AVG(jobs.level_of_interest) as job_interest')
            .joins(:jobs)
            .group('companies.id')
            .order('job_interest desc')
            .take(3)
  end
end
