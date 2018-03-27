class CommentsController < ApplicationController

  def create
    # binding.pry
    @job = Job.find(params[:job_id])
    @comment = @job.comments.new(comment_params)
    @comment.save
    redirect_to job_path(@job)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
