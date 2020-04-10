class PasswordResetsController < ApplicationController
  
  before_action :get_user, only:[:edit, :update]
  before_action :valid_user, only:[:edit, :update]
  
  
  def new
  end
  
  def create
    @user = User.find_by(email:params[:password_reset][:email].downcase)
    if @user 
      @user.create_reset_digest
      @user.send.password_reset_email
      flash[:info] = "再設定用のメールを送信しました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが見つかりませんでした"
      render 'new'
    end 
  end 
  
  def edit
  end
  
  def get_user
    @user = User.find_by(email: params[:email])
  end 
  
  def valid_user
    unless(@user && @user.activated? && @user.authenticated?(:reset,params[:id]))
    redirect_to root_url
    end 
  end 
  
end
