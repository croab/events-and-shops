class CheckoutsController < ApplicationController
  skip_after_action :verify_authorized

  def create
    # checkout_items = checkout_params[:items].map(&:to_h)
    Stripe.api_key=ENV['STRIPE_API_SECRET']
    data = {
      success_url: root_url,
      cancel_url: root_url,
      line_items: [{
        price_data: {
          currency: 'gbp',
          product_data: {
            name: 'Total'
          },
          unit_amount: @cart.total * 100
        },
        quantity: 1
      }],
      mode: 'payment'
    }
    session = Stripe::Checkout::Session.create(data)
    # raise
    redirect_to session.url, allow_other_host: true
  end

  private

  def checkout_params
    params.require(:checkout).permit(items: [])
  end
end
