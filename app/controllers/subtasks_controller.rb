class SubtasksController < ApplicationController
  respond_to :html, :js, :json

  def index
    @tasks = Task.find(params[:task_id]).subtasks
              .order(completed_at: :asc, created_at: :desc)

    respond_to do |format|
      format.json { render json: @tasks }
    end
  end

  def new
    @task = Task.find(params[:task_id]).subtasks.build

    render 'tasks/new'
  end

  def create
    @task = Task.find(params[:task_id]).subtasks.build(task_params)
    @task.save

    respond_with(@task, 'subtasks/create')
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

  def show
    @task = Task.find(params[:id])
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
