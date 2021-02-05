class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  def show
    if logged_in?
      @task=current_user.tasks.build
      @tasks=current_user.tasks.page(params[:page])
    end
    @user=User.find(params[:id])
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    
    if @user.save
      flash[:success]="ユーザ登録しました"
      redirect_to root_url
    else
      flash.now[:danger]="ユーザの登録に失敗しました"
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmination)
  end
end
