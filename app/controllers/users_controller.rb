class UsersController < ApplicationController
  helper_method :user_demo_image, :mypage_demo_image
  skip_before_action :login_required, only: [:index, :new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :correct_user, only: [:create, :edit, :destroy]

  def index
    if current_user
      @users = if current_user.sex == 0
        User.where(sex: 1).order("RAND()").paginate(page: params[:page], per_page: 8)
               else
        User.where(sex: 0).order("RAND()").paginate(page: params[:page], per_page: 8)
               end
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_url, notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  def details 
    @user = User.find(params[:user_id])
    @point = current_user.point
    lose_point
    flash[:notice] = "5ポイント消化。(所持ポイント#{current_user.point})"
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :sex, :character, :hobby, :generation, :point)
    end

    def point_param
      params.require(:user).permit(:point)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      redirect_to(root_url) unless @user == current_user || current_user.admin?
    end

    def gain_point
      current_user.point += 1
      current_user.update(point_param)
      flash[:notice] = "1ポイント獲得。(所持ポイント#{current_user.point})"
    end
  
    def lose_point
      if @point > 5
        @point -= 5
        current_user.update(point: @point)
      else
        @point = 0
        current_user.update(point: @point)
      end
    end

    def user_demo_image
      if current_user.sex == 0
        "figure" + rand(1..6).to_s + ".jpg"
      else
        "figure" + rand(7..12).to_s + ".jpg"
      end
    end

    def mypage_demo_image
      if current_user.sex == 0
        "figure" + rand(7..12).to_s + ".jpg"
      else
        "figure" + rand(1..6).to_s + ".jpg"
      end
    end
end
