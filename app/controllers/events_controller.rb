class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  def index

    puts "OUTPUT: #{params}"
    if params[:search].present? && params[:search][:query].present?
      @events = policy_scope(Event).algolia_search(params[:search][:query])
    #   # raise
    else
      @events = policy_scope(Event)
    end
    @emojis = ['🥹','😂','🥳','🤩','🪄','🎷','🙌','😍','😎','🙏']
  end

  def show
    # Provide event data
    authorize @event
    # Provide attendee data
    @attendees = @event.attendees
    # Check user is in list of attendees
    @current_user_has_booked = current_user_has_booked(@attendees)
    # Return current user's booking if has occurred
    @current_user_booking = EventBooking.find_by(user: current_user, event: @event)
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    authorize @event
    if @event.save!
      redirect_to events_path, notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @event
  end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
    authorize @event
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to events_url, status: :see_other, notice: "Event was successfully deleted."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :photo, :description, :price, :location, :date, :time)
  end

  def search_params
    params.require(:event).permit(:query)
  end

  def current_user_has_booked(attendees)
    attendees.include?(current_user)
  end
end
