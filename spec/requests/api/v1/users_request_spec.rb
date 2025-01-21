require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'GET /api/v1/users' do
    before do
      User.create!(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com')
      User.create!(first_name: 'Jane', last_name: 'Smith', email: 'jane.smith@example.com')
    end

    it 'returns all users' do
      get '/api/v1/users'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data'].size).to eq(2)
      expect(json['data'].first['attributes']['first_name']).to eq('John')
    end
  end

  describe 'GET /api/v1/users/:id' do
    let!(:user) { User.create!(first_name: 'Nancy', last_name: 'Walter', email: 'nancy.walter@example.com') }
    let!(:schedule) { Schedule.create!(title: "Nancy's Schedule", date: Date.today, user: user) }
    let!(:show1) { Show.create!(artist: 'Band A', location: 'Main Stage', date: Date.today, time: '18:00') }
    let!(:show2) { Show.create!(artist: 'Band B', location: 'Side Stage', date: Date.today, time: '20:00') }

    before do
      ScheduleShow.create!(schedule: schedule, show: show1)
      ScheduleShow.create!(schedule: schedule, show: show2)
    end

    it 'returns the user with schedules and shows' do
      get "/api/v1/users/#{user.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['id']).to eq(user.id.to_s)
      expect(json['data']['attributes']['first_name']).to eq('Nancy')
      expect(json['data']['attributes']['schedules'].size).to eq(1)
      expect(json['data']['attributes']['schedules'][0]['shows'].size).to eq(2)
      expect(json['data']['attributes']['schedules'][0]['shows'][0]['artist']).to eq('Band A')
    end

    it 'returns a 404 status and an error message when the user does not exist' do
      get '/api/v1/users/9999'

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('User not found')
    end
  end
end
