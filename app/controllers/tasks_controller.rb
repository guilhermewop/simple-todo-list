class TasksController < ApplicationController
  respond_to :html, :js, :json
  attr_accessor :filter_my_tasks, :filter_public_tasks
  # @@filter_my_tasks = 1
  # @@filter_public_tasks = 0

  def initilize
    @filter_my_tasks = 1
    @filter_public_tasks = 0
  end

  def index
    filter_tasks

    @current_user_tasks = get_my_tasks
    @public_tasks = get_all_public_tasks

    @tasks = @current_user_tasks + @public_tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
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

  def filter_tasks
    # if params[:my_tasks].nil?
    #   @filter_my_tasks = !session[:filter_my_tasks].nil? ? session[:filter_my_tasks] : 1
    # else
    #   @filter_my_tasks = params[:my_tasks].to_i
    # end
    #
    # if params[:public_tasks].nil?
    #   @filter_public_tasks = !session[:filter_public_tasks].nil? ? session[:filter_public_tasks] : 0
    # else
    #   @filter_public_tasks = params[:public_tasks].to_i
    # end
    unless params[:my_tasks].nil?
      @filter_my_tasks = params[:my_tasks].to_i
      if @filter_my_tasks == 1
        @filter_public_tasks = 0
      end
    end

    unless params[:public_tasks].nil?
      @filter_public_tasks = params[:public_tasks].to_i
      if @filter_public_tasks == 1
        @filter_my_tasks = 0
      end
    end

    @filter_my_tasks = 1 if @filter_my_tasks.nil?
    @filter_public_tasks = 0 if @filter_public_tasks.nil?

    session[:filter_my_tasks] = @filter_my_tasks
    session[:filter_public_tasks] = @filter_public_tasks
  end

  def get_my_tasks
    1 == @filter_my_tasks ? Task.only_parent.where(user: current_user).to_a : []
  end

  def get_all_public_tasks
    1 == @filter_public_tasks ? Task.only_parent.shared.where.not(user: current_user).to_a : []
  end
end
