class ApplicationController < ActionController::Base
  # 全てのviewで使用可能にする
  helper_method :current_user

  private

  # 全てのコントローラーで使用可能にする
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
