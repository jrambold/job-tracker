class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments, dependent: :destroy

  def self.evaluate_sort_params(params)
    if params[:sort] == 'location'
      sort_by_location
    elsif params[:sort] == 'interest'
      sort_by_interest
    end
  end

  def self.sort_by_location
    order(:city)
  end

  def self.sort_by_interest
    order(:level_of_interest)
  end
end
