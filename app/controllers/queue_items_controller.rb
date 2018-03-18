class QueueItemsController < ApplicationController
  before_action :check_logged_in_or_redirect

  def index
    @queue_items = current_user.queue_items
  end

  def create
    queue_item = QueueItem.new(user: current_user, video_id: params[:video_id])
    queue_item.position = current_user.next_queue_item_order_num

    if queue_item.save
      flash[:notice] = "New Video added to the Queue"
      redirect_to queue_items_path
    else
      flash.now[:error] = "Could not add this video to the queue"
      redirect_to root_path
    end
  end

  def destroy
    query_item = QueueItem.find(params[:id])

    if query_item.user_id == current_user.id
      query_item.destroy
    end
    redirect_to queue_items_path
  end

  def update_items
    begin
      update_queue_items
    rescue ArgumentError
      redirect_to queue_items_path, alert: "Only positive integers allowed!"
      return
    end

    queue_items = current_user.queue_items
    QueueItem.normalize_positions(queue_items)
    redirect_to queue_items_path, notice: "Positions saved!"
  end

  private

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:positions].each do |queue_item_id, new_position|
        queue_item = QueueItem.find(queue_item_id)
        queue_item.is_valid_number(new_position)
        queue_item.update_attributes!(position: new_position)
      end
    end
  end
end
