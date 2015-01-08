class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :html
  layout 'home'

  def index
    @users = User.all
    respond_with(@users)
  end

  def show
    respond_with(@user)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(@user)
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  # create follow relationship
  def follow
    user = User.find(params[:user])
    unless current_user.following.include?(user)
      current_user.following << user
    end
    render :js => "window.location = '/users'"
  end

  # delete relationship between two nodes
  def unfollow 
    user = User.find(params[:user])
    if current_user.following.include?(user)
      current_user.following(:user, :rel).match_to(user).delete_all(:rel)
    end
    render :js => "window.location = '/users'"
  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name)
    end
end
