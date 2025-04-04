class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  


  def index
    @users = User
      .where(activated: true)
      .select(:id, :name, :email)
      .paginate(page: params[:page])
  end
  def show
    # Redirect to root path if user is not found
    if @user.nil? || !@user.activated
      flash[:danger] = t('.flash.error')
      redirect_to root_url, status: :see_other
    end

    @microposts = @user.microposts
      .select(:id, :user_id, :content, :created_at)
      .paginate(page: params[:page], per_page: Settings.microposts_per_page)
  end
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      # Handle a successful save.
      @user.send_activation_email
      flash[:info] = t('.flash.mail')
      redirect_to root_url
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

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = t('login.not_authorized')
        redirect_to(root_url, status: :see_other) 
      end
    end

    def admin_user
      unless current_user.admin?
        flash[:danger] = t('login.not_authorized')
        redirect_to(root_url, status: :see_other)
      end
    end

    def set_user
      @user = User.find_by(id: params[:id]) 
    end
end
