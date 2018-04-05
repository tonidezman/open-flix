class ReviewsController < ApplicationController
  def create
    @video = Video.find_by(id: params[:review][:video_id])

    if (@review = Review.find_by(user: current_user, video: @video))
      @review.rating = params[:review][:rating]
      @review.body = params[:review][:body]
    else
      @review = Review.new(review_params)
      @review.video = @video
      @review.user = current_user
    end

    if @review.save
      flash[:notice] = "Review successfully saved!"
      redirect_to @video
    else
      @reviews = @video.last_5_reviews
      @reviews_count = @video.reviews.count
      @average_review_score = @video.average_review_score
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
