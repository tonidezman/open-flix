class CategoriesController < ApplicationController
  before_action :check_logged_in_or_redirect

  def show
    @category = Category.find(params[:id])
  end
end
