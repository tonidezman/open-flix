class VideosController < ApplicationController
  def index
    @categories = Category.all_asc.limit(5)
  end

  def show
    @video = Video.find(params[:id])
  end
end
