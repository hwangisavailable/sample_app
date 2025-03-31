class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      # Handle a successful save.
      flash[:success] = t('.flash.success')
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private 
  
    def user_params
      params
        .require(:user)
        .permit(:name, :email, :password, :password_confirmation)
    end
end
