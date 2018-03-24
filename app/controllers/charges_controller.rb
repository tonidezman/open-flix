class PaymentInfoNotSaved < StandardError; end


class ChargesController < ApplicationController
  before_action :check_logged_in_or_redirect
  before_action :redirect_if_already_paid

  def new
  end

  def create
    begin
      @amount = 500

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'OpenFlix customer',
        :currency    => 'eur'
      )

    rescue Stripe::CardError => e
      flash[:danger] = e.message
      redirect_to new_charge_path
      return
    end

    current_user.paid = true
    current_user.reference_id = params[:stripeToken]
    current_user.amount = @amount

    is_payment_data_saved = current_user.update_columns(paid: true, reference_id: params[:stripeToken], amount: @amount)
    unless is_payment_data_saved
      logger.fatal "User: #{current_user.email} payment succeeded but the app could not save paying data to database"
      raise PaymentInfoNotSaved
    end
  end

  private

  def redirect_if_already_paid
    redirect_to home_path if current_user.paid?
  end
end
