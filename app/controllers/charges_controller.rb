class ChargesController < ApplicationController
  before_action :amount_to_be_charged,:description,:authenticate_user!

  def new
  end

  def create
    customer = StripeTool.create_customer(email: params[:stripeEmail], 
                                          stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, 
                                      amount: @amount,
                                      description: 'Rails Stripe customer')

    redirect_to thanks_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def amount_to_be_charged
     @amount = 1000
  end

  # as a private method
  def description
    @description = "Some amazing product"
  end

  def thanks 
  end

end
