require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:artist) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:time) }
  end

  describe 'associations' do
    it { should have_many(:schedule_shows) }
    it { should have_many(:schedules).through(:schedule_shows) }
  end
end
