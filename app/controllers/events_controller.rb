class EventsController < ApplicationController
  include EventsHelper

  def index
    @dates = get_uniq_dates
  end

  def show_events_by_date
    @dates = get_uniq_dates

    selected_date = params[:date]
    @events_on_date = events_by_date(selected_date)

    @tracks = []
    @events_on_date.each do |key, vals|
      vals.each do |e|
        @tracks.push(e.track)
      end
    end

    render 'events_by_date'
  end
end
