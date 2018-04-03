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
    @include_reviews = is_checked(params[:include_reviews])
    @videos = get_videos(@search_term)
    @avg_rating_min = get_min_rating(params[:avg_rating_from])
    @avg_rating_max = get_max_rating(params[:avg_rating_to])

    @videos_found = nil
    @all_videos = nil

    if @search_term.blank?
      @all_videos = Video.search "*", misspellings: { edit_distance: 2 },  where: {
        average_score: { gte: @avg_rating_min, lte: @avg_rating_max }
      }, limit: 5
      @videos_count = @all_videos.count
    else
      query_fields = [:title, :description, :average_score, :reviews_count]
      query_fields << :reviews if @include_reviews
      @videos_found = Video.search @search_term, fields: query_fields, where: {
        average_score: { gte: @avg_rating_min, lte: @avg_rating_max },
      }, highlight: { tag: "<em class='label label-highlight'>" }, limit: 5

      if @videos_found.empty?
        # movie has no reviews yet
        @videos_found = Video.search @search_term, highlight: { tag: "<em class='label label-highlight'>" }, limit: 5
      end

      @videos_count = @videos_found.count
    end
  end

  def advanced_search
    search_term = params[:search_term]
    include_reviews = params[:include_reviews]
    avg_rating_from = params[:rating_from]
    avg_rating_to = params[:rating_to]

    redirect_to search_videos_path(
      search_term: search_term,
      include_reviews: include_reviews,
      avg_rating_from: avg_rating_from,
      avg_rating_to: avg_rating_to
    )
  end

  private

  def is_checked(include_reviews)
    return false if include_reviews.blank?
    return false if include_reviews.to_i.zero?
    true
  end

  def get_max_rating(rating)
    min_avg_rating = 5.0
    return min_avg_rating if rating.blank?
    rating.to_f
  end

  def get_min_rating(rating)
    max_avg_rating = 1.0
    return max_avg_rating if rating.blank?
    rating.to_f
  end

  def get_videos(search_term)
    search_term.present? ? Video.search_by_title(params[:search_term]) : []
  end
end
