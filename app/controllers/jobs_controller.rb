class JobsController < ApplicationController
  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
    else
      if params[:sort] || params[:category] || params[:location]
        @jobs = Job.evaluate_sort_params(params)
        if params[:category]
          @type = params[:category]
        elsif params[:location]
          @type = params[:location]
        end
      else
        @type = 'All'
        @jobs = Job.all
      end
    end
  end

  def new
    @categories = Category.all
    @companies = Company.all
    @company = Company.find(params[:company_id]) if params[:company_id]
    @job = Job.new()
  end

  def create
    if params[:company_id]
      @company = Company.find(params[:company_id])
    else
      @company = Company.find(params[:job][:company_id])
    end
    @categories = Category.all
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to job_path(@job)
    else
      flash[:error] = "Fail"
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @company = @job.company
    @comments = @job.comments
    @comment = Comment.new
  end

  def edit
    @job = Job.find(params[:id])
    @company = @job.company
    @categories = Category.all
  end

  def update
    @job = Job.find(params[:id])
    @job.update(job_params)
    if @job.save
      flash[:success] = "#{@job.title} updated!"
      redirect_to job_path(@job)
    else
      render :edit
    end
  end

  def destroy
    job = Job.find(params[:id])
    company = job.company
    job.destroy

    flash[:success] = "#{job.title} was successfully deleted!"
    redirect_to company_path(company)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end
end
