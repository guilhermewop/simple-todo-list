class SubtasksController < ApplicationController
  respond_to :html, :js, :json

  def index
    @tasks = Task.find(params[:task_id]).subtasks.most_recent

    respond_to do |format|
      format.json { render json: @tasks }
    end
  end

  def create
    @task = Task.find(params[:task_id]).subtasks.build(task_params)
    @task.save

    respond_with(@task)
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @taks = Task.find(params[:id])

    @task.update_attributes(task_params)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_with(@task)
  end

  protected
  def task_params
    params.require(:task).permit(:title)
  end
end
