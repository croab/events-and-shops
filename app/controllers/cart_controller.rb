class CartController < ApplicationController
  def show
    @render_cart = false
    @cart = Cart.find_by(id: session[:cart_id])
    authorize @cart
  end

  def add
    puts "IN ADD"
    @event = Event.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    # puts "A... @event.event_bookings: #{@event.event_bookings}"
    current_event_booking = @event.event_bookings.find_by(event_id: @event.id)
    # puts "B... @event.event_bookings: #{@event.event_bookings}"
    # puts "C... @event.event_bookings.find_by(event_id: @event.id): #{@event.event_bookings.find_by(event_id: @event.id)}"
    if current_event_booking && quantity > 0
      puts "In first"
      current_event_booking.update(quantity:)
    elsif quantity <= 0
      current_event_booking.destroy
    else
      puts "CREATING NEW EVENTBOOKING IN CART"
      @cart.event_bookings.create(event: @event, user: current_user, quantity: quantity)
    end
    # puts "D... new_cart: #{new_cart}"

    authorize @cart
  end

  def remove
    EventBooking.find_by(id: params[:id]).destroy
  end
end
