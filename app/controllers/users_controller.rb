class UsersController < ApplicationController
  before_action :require_log_in_for_edit, only: [:edit, :update, :index, :destroy]
  before_action :require_correct_user_for_edit, only: [:edit, :update]
  before_action :require_admin_for_delete, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  	# debugger
  end

    def new
    @user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:success] = "Sign up complete!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit # removed @user = User.find(params[:id]) because the require_correct_user before_action already does it for us
  end

  def update
    if @user.update_attributes(user_params)
      # updated successfully
      flash[:success] = "Updated succesfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted succesfully"
    redirect_to users_path
  end



  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def require_log_in_for_edit
      unless logged_in?
        store_intended_url
        flash[:danger] = "Please log in"
        redirect_to login_path
      end
    end

    def require_correct_user_for_edit
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def require_admin_for_delete
      redirect_to(root_url) unless current_user.admin?
    end
end
