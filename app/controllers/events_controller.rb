class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(perm_event_params)

    @event.build_creator(id: current_user.id)

    if @event.save
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
    @current_user_attending = @event.event_attendings.where("event_attendee_id = ?", current_user.id).first
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(perm_event_params)
      redirect_to event_path(@event)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to user_path(current_user), status: :see_other
  end

  private

  def perm_event_params
    params.require(:event).permit(:name, :date, :location)
  end
end
