class Event < ApplicationRecord
  belongs_to :track

  def span(time)
    current = Time.parse(time.to_s + ":00").to_i
    finish = Time.parse(self.finish.strftime('%H:%M')).to_i
    span = (finish - current).to_f / 60 * 100
    span.to_s
  end

end
