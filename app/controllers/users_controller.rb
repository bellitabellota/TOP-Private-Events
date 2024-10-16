class UsersController < ApplicationController
  def show
    @events_created = Event.where("creator_id = ?", current_user.id)
    @upcoming_events = current_user.attended_events.map { |event| event if event.date.to_date > Date.current }.compact
    @past_events = current_user.attended_events.map { |event| event if event.date.to_date < Date.current }.compact
  end
end
