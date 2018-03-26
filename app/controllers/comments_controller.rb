class CommentsController < ApplicationController

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.find(params[:job_id])
    @comment = @job.comments.new(comment_params)
    @comment.save
    redirect_to company_job_path(@company, @job)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
