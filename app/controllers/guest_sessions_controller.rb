class GuestSessionsController < ApplicationController
    

    def create
        user = User.find_by(email: "test@example.com")
        session[:user_id] = user.id
        flash[:success] = 'ゲストユーザーでログインしました'
        flash[:warning] = 'よろしくお願いします！'
        redirect_to user
    end
end
