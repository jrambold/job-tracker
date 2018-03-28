class Comment < ApplicationRecord
  belongs_to :job

  def self.order_by_date
    order(created_at: :desc)
  end
end
