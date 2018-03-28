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
    elsif params[:category]
      filter_by_category(params[:category])
    elsif params[:location]
      filter_by_location(params[:location])
    end
  end

  def self.sort_by_location
    all.order(:city)
  end

  def self.sort_by_interest
    all.order(:level_of_interest)
  end

  def self.filter_by_category(category)
    @category = Category.find_by title: category
    where(category_id: @category.id)
  end

  def self.filter_by_location(location)
    where(city: location)
  end
end
