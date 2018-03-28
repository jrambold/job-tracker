class DashboardController < ApplicationController
  def index
    @top = Company.top_companies
    @interest = Job.grouped_interest
    @locations = Job.by_location
  end


end
