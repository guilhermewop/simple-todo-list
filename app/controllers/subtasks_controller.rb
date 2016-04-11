class SubtasksController < ApplicationController
  respond_to :html, :js, :json

  def index
    @tasks = Task.find(params[:task_id]).subtasks
              .order(completed_at: :asc, created_at: :desc)
  end

  def new
    @task = Task.find(params[:task_id]).subtasks.build
    render 'tasks/new'
  end

  def create
    @parent = Task.find(params[:task_id])
    @task = @parent.subtasks.build(task_params)
    @task.save
    respond_with(@parent, @task)
  end

  def edit
    @task = Task.find(params[:id])
    render 'tasks/edit'
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    @parent = @task.parent

    respond_with(@parent, @task)
  end

  def destroy
    @task = Task.find(params[:id])
    @parent = @task.parent
    @task.destroy

    respond_with(@parent, @task)
  end

  def completed
    @task = Task.find(params[:id])
    complete = 'true' == params[:complete] ? Time.now : false
    @task.update(completed_at: complete)
  end

  protected
  def task_params
    params.require(:task).permit(:title)
  end

end
