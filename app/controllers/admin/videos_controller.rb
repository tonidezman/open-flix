class Admin::VideosController < AdminController

  def new
    @video = Video.new
    @category_options = Category.all.map { |category| [category.name, category.id] }
  end

  def create
  end

end
