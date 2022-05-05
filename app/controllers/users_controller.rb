class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order("RAND()").all
  end

  def show
   
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to users_url, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user = User.update(user_params)
    if @user.save
      redirect_to users_url, notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :sex, :character, :hobby, :generation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_sex
      if @user.sex == 0
        "女性"
      else
        "男性"
      end
    end

    def set_generation
      if @user.generation == 0
        "10代"
      elsif @user.generation == 1
        "20代"
      elsif @user.generation == 2
        "30代"
      elsif @user.generation == 3
        "40代"
      elsif @user.generation == 4
        "50代"
      else
        "60代以上"
      end
    end

    helper_method :set_sex, :set_generation
end
