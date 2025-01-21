require 'rails_helper'

RSpec.describe 'Schedules API', type: :request do
  describe 'GET /api/v1/schedules' do
    before do
      user = User.create!(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com')
      5.times do |i|
        Schedule.create!(title: "Schedule #{i + 1}", date: Date.today, user: user)
      end
    end

    it 'returns all schedules' do
      get '/api/v1/schedules'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data'].size).to eq(5)
      expect(json['data'].first['attributes']['title']).to eq('Schedule 1')
    end
  end

  describe 'GET /api/v1/schedules/:id' do
    let!(:user) { User.create!(first_name: 'Jane', last_name: 'Smith', email: 'jane.smith@example.com') }
    let!(:schedule) { Schedule.create!(title: 'Jane’s Schedule', date: Date.today, user: user) }
    let!(:show1) { Show.create!(artist: 'Band A', location: 'Main Stage', date: Date.today, time: '18:00') }
    let!(:show2) { Show.create!(artist: 'Band B', location: 'Side Stage', date: Date.today, time: '19:00') }

    before do
      ScheduleShow.create!(schedule: schedule, show: show1)
      ScheduleShow.create!(schedule: schedule, show: show2)
    end

    it 'returns the schedule with associated shows' do
      get "/api/v1/schedules/#{schedule.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['id']).to eq(schedule.id.to_s)
      expect(json['data']['attributes']['title']).to eq('Jane’s Schedule')
      expect(json['data']['attributes']['shows'].size).to eq(2)
    end

    it 'returns a 404 status and an error message when schedules does not exist' do
      get '/api/v1/schedules/9999'

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Schedule not found')
    end
  end

  describe 'DELETE /api/v1/schedules/:schedule_id/shows/:show_id' do
    let!(:user) { User.create!(first_name: 'Nancy', last_name: 'Walter', email: 'nancy.walter@example.com') }
    let!(:schedule) { Schedule.create!(title: "Nancy's Schedule", date: Date.today, user: user) }
    let!(:show) { Show.create!(artist: 'Band C', location: 'VIP Stage', date: Date.today, time: '20:00') }
    let!(:schedule_show) { ScheduleShow.create!(schedule: schedule, show: show) }

    
    it 'removes the show from the schedule' do
      expect {
        delete "/api/v1/schedules/#{schedule.id}/shows/#{show.id}"
      }.to change(ScheduleShow, :count).by(-1)

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['message']).to eq('Show removed from schedule successfully')
    end

    it 'does not delete the schedule or the show itself' do
      delete "/api/v1/schedules/#{schedule.id}/shows/#{show.id}"

      expect(Schedule.exists?(schedule.id)).to be true
      expect(Show.exists?(show.id)).to be true
    end
  
    it 'returns a 404 status when the show is not part of the schedule' do
      delete "/api/v1/schedules/#{schedule.id}/shows/9999"

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Show or schedule not found')
    end

    it 'returns a 404 status when the schedule does not exist' do
      delete "/api/v1/schedules/9999/shows/#{show.id}"

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Show or schedule not found')
    end
  end
end
