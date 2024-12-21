class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :require_login # 追記
  allow_browser versions: :modern
  
  private

  def not_authenticated
    redirect_to login_path
  end
end
