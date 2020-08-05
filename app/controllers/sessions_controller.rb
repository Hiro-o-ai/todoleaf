class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    # .authenticateはhas_secure_passwordをUserクラスに追記した時に追加されたメソッド
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました。"
    else
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end