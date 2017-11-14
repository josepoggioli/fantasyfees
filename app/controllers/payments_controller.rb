class PaymentsController < ApplicationController
  before_action :amount_to_be_charged,:description,:authenticate_user!

  def new
    @user_league = UserLeague.find(params[:id])
  end

  def create
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

    @payment = Payment.new(
      amount: params[:amount].to_i*100,
      user_league_id: params[:user_league_id]
    )

    if @payment.save
      redirect_to "/payments/#{@payment.id}"
    else
      puts @payment.errors.messages
      redirect_to "/payments/error"
    end 

    rescue Stripe::CardError => e
    flash[:error] = e.message
    
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def error
  end

  def amount_to_be_charged
    @amount = 500
  end

  def description
    @description = "Fantasy Fees payment"
  end

end
