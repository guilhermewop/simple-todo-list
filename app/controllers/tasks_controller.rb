class TasksController < ApplicationController
  respond_to :html, :js, :json

  def index
    @tasks = Task.only_parent.order(completed_at: :asc, created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save

    respond_with(@task)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)

    respond_with(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_with(@task)
  end

  def completed
    @task = Task.find(params[:id])
    complete = 'true' == params[:complete] ? Time.now : false
    @task.update(completed_at: complete)
  end

  def privacy
    @task = Task.find(params[:id])
    privacy = 'true' == params[:private]
    @task.update(is_private: privacy)
  end

  private
  def task_params
    params.require(:task).permit(:title, :public, :is_private)
  end
end
