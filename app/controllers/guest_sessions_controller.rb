class GuestSessionsController < ApplicationController
    

    def create
        user = User.find_or_create_by(name:"ゲストユーザー", email: "test@example.com",
        password_digest: SecureRandom.urlsafe_base64)
        
        session[:user_id] = user.id
        flash[:success] = 'ゲストユーザーでログインしました'
        flash[:warning] = 'よろしくお願いします！'
        redirect_to root_url
    end
    
    def home
    if logged_in?
      @post = current_user.posts.build 
      @feed_items = current_user.feed.paginate(page: params[:page])
    end 
    end
    
end
