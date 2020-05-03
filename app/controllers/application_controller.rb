class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :address, :zip_code, :phone_number])
      devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :address, :zip_code, :phone_number])
    end
    # ログイン後に遷移する
    def after_sign_in_path_for(resource)
        if resource.instance_of?(Admin)
          admins_path
        elsif resource.instance_of?(User)
          root_path
        else
          root_path
        end
    end
  
    # ログアウト後に遷移するpathを設定
    def after_sign_out_path_for(resource)
        if resource == :admin
          admins_path
        elsif resource == :user
          root_path
        else
          root_path
        end
    end
end
