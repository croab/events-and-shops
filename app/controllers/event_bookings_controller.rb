class EventBookingsController < ApplicationController
  def create
    @event_booking = EventBooking.new
    @event_booking.user = current_user
    event = Event.find(params[:event_id])
    @event_booking.event = event
    if @event_booking.save!
      redirect_to event_path(event), notice: "Event was successfully created."
    else
      render event_path(event), status: :unprocessable_entity
    end
    authorize @event_booking
  end

  def destroy
    @event_booking = EventBooking.find(params[:id])
    authorize @event_booking
    @event_booking.destroy
    redirect_to event_path(@event_booking.event), status: :see_other, notice: "Booking was successfully destroyed."
  end
end
