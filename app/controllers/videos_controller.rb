class VideosController < ApplicationController
  before_action :check_logged_in_or_redirect

  def index
    @categories = Category.all_asc.limit(5)
  end

  def show
    @video = Video.find(params[:id])
    @review = Review.new

    @reviews = @video.last_5_reviews
    @reviews_count = @video.reviews.count
    @average_review_score = @video.average_review_score
  end

  def search
    @videos = Video.search_by_title(params[:search_term])
  end
end
