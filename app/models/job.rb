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

  def self.grouped_interest
    group_range = [(1..25), (26..50), (51..75), (76..100), (101..125)]
    groups = {
      "1 to 25" => 0,
      "26 to 50" => 0,
      "51 to 75" => 0,
      "76 to 100" => 0,
      "101 to 125" => 0
    }
    interest_count.each do |interest, jobs|
      if group_range[0].include?(interest)
        groups["1 to 25"] += jobs
      elsif group_range[1].include?(interest)
        groups["26 to 50"] += jobs
      elsif group_range[2].include?(interest)
        groups["51 to 75"] += jobs
      elsif group_range[3].include?(interest)
        groups["76 to 100"] += jobs
      elsif group_range[4].include?(interest)
        groups["101 to 125"] += jobs
      end
    end
    groups
  end

  def self.by_location
    Job.group(:city)
      .count
  end

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
