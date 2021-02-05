class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if logged_in?
      @task=current_user.tasks.build
      @tasks=current_user.tasks.page(params[:page])
    end
  end

  def show
  end

  def create
    @task=current_user.tasks.build(task_params)
    if @task.save
      flash[:success]='タスクが正常に登録されました。'
      redirect_to root_url
    else
      @tasks=current_user.tasks.all
      flash.now[:danger]='タスクが正常に登録されませんでした。'
      render :index
    end
  end

  def destroy
    @task.destroy
    flash[:success]='タスクは正常に削除されました'
    redirect_to tasks_url
  end

  def new
    @task=Task.new
  end

  def update
    if @task.update(task_params)
      flash[:success]='タスクが正常に更新されました。'
      redirect_to current_user
    else
      flash.now[:danger]='タスクが正常に更新されませんでした。'
      render:index
    end  
  end

  def edit
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content,:status)
  end
end
