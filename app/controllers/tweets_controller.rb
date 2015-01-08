class TweetsController < ApplicationController
  before_action :authenticate_user!
  layout 'home'
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def home
    @user = User.find(params[:user]) || current_user
    #@user = user || current_user
    @user_tweets = @user.following.tweets
    @tweets = @user.tweets
    @tweet = Tweet.new
  end

  def index
   # @tweets = current_user.tweets
    @user_tweets = current_user.following.tweets
    @tweets = current_user.tweets
    @tweet = Tweet.new
  end

  def temp
    @tweets = Tweet.all
    respond_with(@tweets)
  end

  def show
    respond_with(@tweet)
  end

  def new
    @tweet = Tweet.new
    @users = User.all
    respond_with(@tweet)
  end

  def edit
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      @tweet.user = current_user
      redirect_to action: :home
    else
      respond_with(@tweet)
    end
  end

  def update
    @tweet.update(tweet_params)
    respond_with(@tweet)
  end

  def destroy
    @tweet.destroy
    respond_with(@tweet)
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:message, :user)
    end
end
