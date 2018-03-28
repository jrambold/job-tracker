class DashboardController < ApplicationController
  def index
    @top = Company.top_companies
    @interest = Job.interest_count
    @locations = Job.by_location
  end


end
