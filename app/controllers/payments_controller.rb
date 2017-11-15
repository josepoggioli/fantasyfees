class PaymentsController < ApplicationController
  before_action :description,:authenticate_user!

  def new
    @user_league = UserLeague.find(params[:id])
  end

  def create
    payment = Payment.new(
      amount: params[:amount].to_i*100,
      user_league_id: params[:user_league_id]
    )
    user = payment.user_league

    if user.league.fee - user.total_payments - (payment.amount/100) < 0
      flash[:warning] = "Your payment is larger than your balance. Please try your payment again."
      redirect_to "/payments/error"
    else
      if payment.save
        customer = Stripe::Customer.create(
          email: params[:stripeEmail],
          source: params[:stripeToken]
        )

        charge = Stripe::Charge.create(
          customer: customer.id,
          amount: params[:amount].to_i*100,
          description: @description,
          currency: 'usd'
        )

        flash[:primary] = "Your $#{payment.pretty_amount} has been submitted!"
        redirect_to "/leagues/#{payment.user_league.league.id}"
      else
        puts payment.errors.messages
        redirect_to "/payments/error"
      end
    end

    rescue Stripe::CardError => e
    flash[:error] = e.message
    
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def error
  end

  def description
    @description = "Fantasy Fees payment"
  end

end
