class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments, dependent: :destroy

  def self.interest_count
    Job.group(:level_of_interest)
      .order('level_of_interest desc')
      .count
  end

  def self.by_location
    Job.group(:city)
      .count
  end
end
