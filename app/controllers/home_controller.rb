class HomeController < ApplicationController
  before_filter :check_user_logged_in
  layout 'application'
  def index
    
  end

  def check_user_logged_in
    redirect_to "/tweets" if user_signed_in?
  end
end
