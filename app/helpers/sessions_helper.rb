module SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_url
  end

  def check_logged_in_or_redirect
    unless logged_in?
      redirect_to landing_page_path
    end
  end

end
