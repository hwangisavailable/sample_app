class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def show
    # Redirect to root path if user is not found
    if @user.nil?
      flash[:danger] = t('.flash.error')
      redirect_to root_url, status: :see_other
    end
  end
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      # Handle a successful save.
      reset_session
      log_in @user

      flash[:success] = t('.flash.success')
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = t('.flash.success')
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:success] = t('.flash.success', name: @user.name)
    @user.destroy

    redirect_to users_url, status: :see_other
  end

  private 
  
    def user_params
      params
        .require(:user)
        .permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find_by(id: params[:id]) 
    end
end
