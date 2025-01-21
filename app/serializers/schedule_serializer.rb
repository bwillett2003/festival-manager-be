class ScheduleSerializer
  include JSONAPI::Serializer

  attributes :title, :date

  attribute :shows do |schedule|
    schedule.shows.order(:time).map do |show|
      {
        id: show.id,
        artist: show.artist,
        location: show.location,
        date: show.date,
        time: show.time.strftime('%H:%M:%S')
      }
    end
  end
end
