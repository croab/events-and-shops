class CartController < ApplicationController
  def show
    @render_cart = false
    @cart = Cart.find_by(id: session[:cart_id])
    authorize @cart
  end

  def add
    @event = Event.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_event_booking = @event.event_bookings.find_by(event_id: @event.id)
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
    authorize @event_booking, policy_class: CartPolicy
  end
end
