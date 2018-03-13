class ReviewsController < ApplicationController
  def create
    @video = Video.find_by(id: params[:review][:video_id])
    @review = Review.new(review_params)
    @review.video = @video
    @review.user = current_user

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
