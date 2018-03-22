class Admin::VideosController < AdminController

  def new
    @video = Video.new
    @category_options = Category.all.map { |category| [category.name, category.id] }
  end

  def create
    @video = Video.new(video_params)
    @category_options = Category.all.map { |category| [category.name, category.id] }
    if @video.save
      flash[:notice] = "Video: #{@video.title} saved."
      redirect_to @video
    else
      render new_admin_video_path
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :category_id, :small_cover_url, :large_cover_url)
  end
end
