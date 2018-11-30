class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation　]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    mypage_path(resource)
  end

  def authenticate_user
    if current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/users/sign_in")
    end
  end

  def general_user #msgtype作成ページへのアクセス制限
    if !(current_user.id == 1)
      flash[:notice] = "存在しないページです"
      redirect_to("/users/sign_in")
    end
  end

end
