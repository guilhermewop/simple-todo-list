class TasksController < ApplicationController
  respond_to :html, :js, :json

  def index
    @tasks = Task.only_parent.most_recent
  end

  def new
    @task = Task.new
  end

  def completed
    @task = Task.find(params[:id])
    complete = 'true' == params[:complete] ? Time.now : false

  	@task.update(completed_at: complete)

    # render nothing: true
    # render json: @task
	end

  def privacy
    @task = Task.find(params[:id])
    privacy = 'false' == params[:private]

    @task.update(is_public: privacy)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    @task.update(task_params)
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

  private
  def task_params
    params.require(:task).permit(:title, :public)
  end
end
