class VideosController < ApplicationController
  def index
    @categories = Category.all.limit(5)
  end

  def show
    @video = Video.find(params[:id])
  end
end
