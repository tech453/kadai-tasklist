class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy,:edit,:show,:update]# before_action :require_user_logged_in, only: [:show]
  # before_action :set_task, only: [:show, :edit, :update, :destroy]
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
    @task=current_user.tasks.build
  end

  def update
    if @task.update(task_params)
      flash[:success]='タスクが正常に更新されました。'
      redirect_to root_url
    else
      flash.now[:danger]='タスクが正常に更新されませんでした。'
      render:index
    end  
  end

  def edit
  end
  
  private
  
  # def set_task
  #   @task = Task.find(params[:id])
  # end

  def task_params
    params.require(:task).permit(:content,:status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      flash[:danger]="そのタスクにはアクセスできません"
      redirect_to root_url
    end
  end
end
