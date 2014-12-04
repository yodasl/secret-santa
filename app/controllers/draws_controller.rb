class DrawsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    if @event.draws.any?
      redirect_to event_draw_url(@event)
    end
  end

  def show
    @event = Event.find(params[:event_id])
    if @event.draws.empty?
      redirect_to new_event_draw_url
    end
  end

  def create
    @event = Event.find(params[:event_id])
    for (giver, receiver) in @event.draw_order
      draw = Draw.new(giver: giver, receiver: receiver)
      @event.draws << draw
      draw.save
    end
    flash[:success] = 'Draw has been made'
    redirect_to @event
  end
end
