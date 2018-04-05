class Admin::RecentPaymentsController < AdminController
  def index
    @recent_payments = User.where(paid: true).order(:updated_at).limit(20)
  end
end
