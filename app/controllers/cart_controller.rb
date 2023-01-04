require 'stripe'
require 'sinatra'

class CartController < ApplicationController
  def show
    @render_cart = false
    @cart = Cart.find_by(id: session[:cart_id])
    authorize @cart
  end

  def add
    @event = Event.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_event_booking = @event.event_bookings.find_by(event_id: @event.id, user_id: current_user)
    if current_event_booking && quantity > 0
      current_event_booking.update(quantity:)
    elsif quantity <= 0
      current_event_booking.destroy
    else
      @cart.event_bookings.create(event: @event, user: current_user, quantity: quantity)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
          [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart }),
            turbo_stream.replace(@event, partial: 'events/show_event_card', locals: { event: @event, attendees: @attendees = @event.attendees })]
      end
    end

    authorize @cart
  end

  def remove
    @event_booking = EventBooking.find_by(id: params[:id])
    @event_booking.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart })
      end
    end

    authorize @event_booking, policy_class: CartPolicy
  end

  def make_payment
    key = ENV["STRIPE_API_KEY"]

    set :static, true
    set :port, 4242

    domain=ENV["DOMAIN"]

    @cart = Cart.find_by(id: session[:cart_id])
    cart_items = []

    @cart.event_bookings do |event_booking|
      quantity = event_booking.quantity
      price = event_booking.event.price
      cart_items << { price: price, quantity: quantity }
    end

    content_type 'application/json'

    session = Stripe::Checkout::Session.create({
      line_items: cart_items,
      mode: 'payment',
      success_url: domain + '/success.html',
      cancel_url: domain + '/cancel.html',
    })
    redirect session.url, 303

  end

  def success

  end

  def cancel

  end
end
