# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]
   before_action :authenticate_user, {only: [:my_page, :update_image]}

   def my_page
     @user = User.find(current_user.id)
     @rooms = current_user.rooms
   end

   def update_image
     @user = User.find_by(id: params[:id])
     image = params[:image]
     if File.binwrite("public/user_images/#{@user.id}.jpg", image.read)
       @user.update_attributes(image_name: "#{@user.id}.jpg")
       flash[:notice] = "画像を変更しました。変更が反映されていない場合はキャッシュをクリアしてください。"
       redirect_to("/users/my_page")
     else
       flash[:notice] = "画像の変更に失敗しました。"
       redirect_to("/users/my_page")
     end
   end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
   def create
     super
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:name])
   end

   def after_update_path_for(resource)
     mypage_path(resource)
   end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
