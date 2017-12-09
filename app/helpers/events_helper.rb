module EventsHelper
  def get_uniq_dates
    @events = Event.all
    @dates = []
    @events.each do |ev|
      @dates.push(ev["start"].beginning_of_day.to_date)
    end
    @dates.uniq
  end

  def events_by_date(selected_date)
    date_range = selected_date.to_time.beginning_of_day..selected_date.to_time.end_of_day
    @events = Event.where(start: date_range).order("start").group_by { |ev| ev.start.hour }
  end
end
