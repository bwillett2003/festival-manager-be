require 'rails_helper'

RSpec.describe ScheduleShow, type: :model do
  describe 'validations' do
    let!(:schedule) { Schedule.create!(title: "Test Schedule", date: Date.today, user: User.create!(first_name: "Test", last_name: "User", email: "test@example.com")) }
    let!(:show) { Show.create!(artist: "Test Artist", location: "Main Stage", date: Date.today, time: "18:00") }
    let!(:schedule_show) { ScheduleShow.create!(schedule: schedule, show: show) }

    it {
      expect(schedule_show).to validate_uniqueness_of(:show_id)
        .scoped_to(:schedule_id)
        .with_message('is already added to this schedule')
    }
  end
end

