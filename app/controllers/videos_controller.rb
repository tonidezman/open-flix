class VideosController < ApplicationController
  def index
    @videos = Video.all.limit(6)
  end
end
