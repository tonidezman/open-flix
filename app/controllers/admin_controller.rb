class AdminController < ApplicationController
  before_action :check_logged_in_or_redirect, :redirect_if_not_admin

  private

  def redirect_if_not_admin
    redirect_to home_path unless current_user.is_admin?
  end
end