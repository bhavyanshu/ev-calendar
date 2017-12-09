require 'csv'

namespace :import do

  desc "Import events data from csv"
  task :events => :environment do
    @tracks = []
    db_path = Rails.root.join('db')
    csv = File.read(db_path + 'test_events.csv')
    data = CSV.parse(csv, :headers => true)
    data.each do |row|
      @track = row["track"]
      @tracks.push(@track)
    end

    @priority_tracks = []
    @generic_tracks = []
    highest_avail_order = 0

    @tracks.uniq.each do |val|
      sequence = /\d+/.match(val)

      if sequence.nil? or sequence[0].empty?
        # generic tracks
        @generic_tracks.push({"name" => val})
      else
        # tracks with numbers
        @priority_tracks.push({"name" => val, "order" => sequence[0]})
        if sequence[0].to_i > highest_avail_order
          highest_avail_order = sequence[0].to_i
        end
      end
    end

    next_order = highest_avail_order + 1
    @generic_tracks.each do |gt|
      gt["order"] = next_order
      next_order = next_order + 1
    end

    # Tracks are ready to be stored
    @tracks = @priority_tracks.concat(@generic_tracks)

    # Let's load tracks first
    @tracks.map {|t| Track.new(t).save }
    @stored_tracks = Track.all

    @events = []
    data.each do |ev|
      track_record = @stored_tracks.find {|st| st.name.include?(ev["track"]) }
      ev["track"] = track_record
      @events.push(ev.to_h)
    end

    # Now load events with corresponding tracks
    @events.map {|ev| Event.new(ev).save }
  end

end
