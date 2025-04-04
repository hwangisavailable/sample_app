class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :logged_in_user, only: [:create, :destroy]

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t('login.not_authenticated')
        redirect_to login_url, status: :see_other
      end
    end
end
