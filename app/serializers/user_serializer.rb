class UserSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :email

  attribute :schedules do |user|
    user.schedules.map do |schedule|
      {
        id: schedule.id,
        title: schedule.title,
        date: schedule.date,
        shows: schedule.shows.order(:time).map do |show|
          {
            id: show.id,
            artist: show.artist,
            location: show.location,
            date: show.date,
            time: show.time.strftime('%H:%M:%S')
          }
        end
      }
    end
  end
end
