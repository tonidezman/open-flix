class QueueItemsController < ApplicationController
  before_action :check_logged_in_or_redirect

  def index
    @queue_items = current_user.queue_items
  end
end
