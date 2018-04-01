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
    @search_term = params[:search_term]
    @videos = if @search_term.present?
                Video.search_by_title(params[:search_term])
              else
                []
              end
  end

  def search_form_submitted
    redirect_to search_videos_path(search_term: params[:search_term])
  end
end
