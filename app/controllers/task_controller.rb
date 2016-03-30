class TaskController < ApplicationController
  respond_to :html, :js, :json

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

  def create
    @task  = Task.new(task_params)
    @task.save

    respond_with(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_with(@task)
  end
end
